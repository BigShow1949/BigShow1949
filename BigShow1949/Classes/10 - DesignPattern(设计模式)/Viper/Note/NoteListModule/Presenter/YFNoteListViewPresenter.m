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

@interface YFNoteListViewPresenter ()
@property (nonatomic, weak) id<YFViperView>view;
// 外面是遵守YFViperWireframePrivate协议，里面用wireframe，遵守的是 YFNoteListWireframeInput
@property (nonatomic, strong) id<YFNoteListWireframeInput> wireframe;
@property (nonatomic, strong) id<YFViperInteractor,YFNoteListInteractorInput> interactor;

@end


@implementation YFNoteListViewPresenter


#pragma mark - YFViperPresenter

#pragma mark - YFNoteListViewEventHandler
- (void)didTouchNavigationBarAddButton {
    [self.wireframe presentEditorForCreatingNewNoteWithDelegate:self completion:nil];
}

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath {return YES;}
- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - YFViperViewEventHandler
- (void)handleViewReady {
    // 对数据进行“nil”判断
    [self.interactor loadAllNotes];
}
- (void)handleViewRemoved {}
- (void)handleViewWillAppear:(BOOL)animated {}
- (void)handleViewDidAppear:(BOOL)animated {}
- (void)handleViewWillDisappear:(BOOL)animated {}
- (void)handleViewDidDisappear:(BOOL)animated {}

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
