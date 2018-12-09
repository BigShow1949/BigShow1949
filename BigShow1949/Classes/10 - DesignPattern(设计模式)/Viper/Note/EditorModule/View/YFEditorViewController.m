//
//  YFEditorViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFEditorViewController.h"

#import "YFEditorViewDataSource.h"
#import "YFEditorViewEventHandler.h"

@interface YFEditorViewController ()
@property (nonatomic, strong) id<YFEditorViewEventHandler> eventHandler;
@property (nonatomic, strong) id<YFEditorViewDataSource> viewDataSource;
@end

@implementation YFEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Private
- (void)setupNav {
    self.title = @"Editor";
    UIBarButtonItem *addNoteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.eventHandler action:@selector(didTouchNavigationBarDoneButton)];
    self.navigationItem.rightBarButtonItem = addNoteItem;
    
//    if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
//        [self.eventHandler handleViewReady];
//    }
}

- (void)done {
    
}




@end
