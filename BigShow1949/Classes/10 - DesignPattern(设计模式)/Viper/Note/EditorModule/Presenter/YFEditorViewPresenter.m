//
//  YFEditorViewPresenter.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFEditorViewPresenter.h"

#import "YFEditorWireframeInput.h"
#import "YFViperView.h"
#import "YFViperInteractor.h"
#import "YFEditorViewProtocol.h"
#import "YFEditorInteractorInput.h"
#import "YFEditorDelegate.h"

@interface YFEditorViewPresenter()

@property (nonatomic, strong) id<YFEditorWireframeInput> wireframe;
@property (nonatomic, weak) id<YFViperView,YFEditorViewProtocol> view;
@property (nonatomic, strong) id<YFViperInteractor,YFEditorInteractorInput> interactor;

@end

@implementation YFEditorViewPresenter


#pragma mark - YFViperViewEventHandler
- (void)handleViewReady {
    if (self.view.editMode == YFEditorModeModify) {
        [self.view updateTitleString:[self.interactor currentEditingNoteTitle]];
        [self.view updateContentString:[self.interactor currentEditingNoteContent]];
    }
}
- (void)handleViewRemoved {}
- (void)handleViewWillAppear:(BOOL)animated {}
- (void)handleViewDidAppear:(BOOL)animated {}
- (void)handleViewWillDisappear:(BOOL)animated {}
- (void)handleViewDidDisappear:(BOOL)animated {}

#pragma mark - YFEditorViewEventHandler
- (void)didTouchNavigationBarDoneButton {
    // 存储信息
    [self.interactor storeCurrentEditingNote];
    
    // 页面跳转
    id<YFEditorDelegate> delegate = self.view.delegate;
    NSLog(@"[delegate class] = %@", [delegate class]); // YFNoteListViewPresenter
    if ([delegate respondsToSelector:@selector(editor:didFinishEditNote:)]) {
        [delegate editor:(UIViewController *)self.view didFinishEditNote:[self.interactor currentEditingNote]];
    }
}

- (id<YFViperRouter>)router {
    return self.wireframe.router;
}

#pragma mark - YFEditorInteractorDataSource
- (nullable NSString *)currentEditingNoteTitle {
    return [self.view titleString];
}
- (nullable NSString *)currentEditingNoteContent {
    return [self.view contentString];
}
@end
