//
//  YFNoteListViewController.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteListViewController.h"

#import "YFNoteListViewDataSource.h"
#import "YFNoteListViewEventHandler.h"
#import "YFViperViewPrivate.h"  // 先暂时写在这里
@interface YFNoteListViewController ()<YFViperViewPrivate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) id<YFNoteListViewEventHandler> eventHandler;
@property (nonatomic, strong) id<YFNoteListViewDataSource> viewDataSource;

@end

@implementation YFNoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"NoteList";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
}

- (UIViewController *)routeSource {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.eventHandler handleViewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.eventHandler handleViewDidAppear:animated];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(viewWillDisappear:)]) {
        [self.eventHandler handleViewWillDisappear:animated];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewDataSource numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self.viewDataSource textOfCellForRowAtIndexPath:indexPath];
    NSString *detailText = [self.viewDataSource detailTextOfCellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath
                                                   text:text
                                             detailText:detailText];
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.eventHandler canEditRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.eventHandler handleDeleteCellForRowAtIndexPath:indexPath];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.eventHandler handleDidSelectRowAtIndexPath:indexPath];
}

#pragma mark - YFNoteListViewProtocol
//- (UITableView *)noteListTableView {}
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
                                      text:(NSString *)text
                                detailText:(NSString *)detailText {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"noteListCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"noteListCell"];
    }
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    return cell;
}

#pragma mark - Private
- (void)setupNav {
    UIBarButtonItem *addNoteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self.eventHandler action:@selector(didTouchNavigationBarAddButton)];
    self.navigationItem.rightBarButtonItem = addNoteItem;
    
    if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
        [self.eventHandler handleViewReady];
    }
}

@end
