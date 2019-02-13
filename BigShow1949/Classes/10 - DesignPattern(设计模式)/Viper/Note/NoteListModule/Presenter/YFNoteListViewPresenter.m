//
//  YFNoteListViewPresenter.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteListViewPresenter.h"
#import "YFViperView.h"
#import "YFNoteListWireframeInput.h" // 引入的是input协议，不是导入YFNoteListWireframe.h,虽然.h里面也声明了
#import "YFViperInteractor.h"
#import "YFNoteListInteractorInput.h"
//#import "YFNoteListInteractor.h"
#import "YFNoteListViewProtocol.h"
#import "YFEditorDelegate.h"
#import "YFLoginViewDelegate.h"
@interface YFNoteListViewPresenter ()<YFEditorDelegate,YFLoginViewDelegate>
@property (nonatomic, weak) id<YFViperView,YFNoteListViewProtocol>view;
// 外面是遵守YFViperWireframePrivate协议，里面用wireframe，遵守的是 YFNoteListWireframeInput
@property (nonatomic, strong) id<YFNoteListWireframeInput> wireframe;
@property (nonatomic, strong) id<YFViperInteractor,YFNoteListInteractorInput> interactor;

@property (nonatomic, assign) BOOL logined;

@end


@implementation YFNoteListViewPresenter


#pragma mark - YFViperPresenter

#pragma mark - YFNoteListViewEventHandler
- (void)didTouchNavigationBarAddButton {
    [self.wireframe presentEditorForCreatingNewNoteWithDelegate:self completion:nil];
}

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath {return YES;}
- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.interactor deleteNoteAtIndex:indexPath.row];
}
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *uuid = [self.interactor noteUUIDAtIndex:indexPath.row];
    NSString *title = [self.interactor noteTitleAtIndex:indexPath.row];
    NSString *content = [self.interactor noteContentAtIndex:indexPath.row];
    NSLog(@"uuid = %@, title = %@, contet = %@", uuid, title, content);
    [self.wireframe pushEditorViewForEditingNoteWithUUID:uuid title:title content:content delegate:self];
}

#pragma mark - YFViperViewEventHandler
- (void)handleViewReady {
    // 对数据进行“nil”判断
    [self.interactor loadAllNotes];
}
- (void)handleViewRemoved {}
- (void)handleViewWillAppear:(BOOL)animated {}
- (void)handleViewDidAppear:(BOOL)animated {
    if (!self.logined) {
        [self.wireframe presentLoginViewWithMessage:@"login with message" delegate:self completion:nil];
    }
}
- (void)handleViewWillDisappear:(BOOL)animated {}
- (void)handleViewDidDisappear:(BOOL)animated {}

#pragma mark - YFEditorDelegate
- (void)editor:(UIViewController *)editor didFinishEditNote:(YFNoteModel *)note {
    [self.wireframe quitEditorViewWithAnimated:YES];
    [self.view.tableView reloadData];
}

#pragma mark - YFNoteListViewDataSource
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.interactor noteCount];
}
- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.interactor titleForNoteAtIndex:indexPath.row];
    return title;
}
- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *content = [self.interactor contentForNoteAtIndex:indexPath.row];
    return content;
}























@end
