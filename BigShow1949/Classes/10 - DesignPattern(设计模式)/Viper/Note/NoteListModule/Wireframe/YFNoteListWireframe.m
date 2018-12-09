//
//  YFNoteListWireframe.m
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteListWireframe.h"
#import <objc/runtime.h>

#import "YFViperView.h"
#import "YFNoteListRouter.h"
#import "YFRouter.h"
#import "YFViperWireframePrivate.h"
#import "YFRouter+YFEditor.h"

// YFViperWireframePrivate 遵守这个协议有啥用，提示view跟router赋值？
@interface YFNoteListWireframe()<YFViperWireframePrivate>
@property (nonatomic, weak) id<YFViperView> view;
//@property (nonatomic, strong) id<YFNoteListRouter> router;
@property (nonatomic, strong) id router; // 加这个就报错<YFNoteListRouter>
@property (nonatomic, weak) UIViewController *editor;


@end

@implementation YFNoteListWireframe

#pragma mark - YFNoteListWireframeInput
- (void)presentEditorForCreatingNewNoteWithDelegate:(id<YFEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion {

    // [self.router class] 这里的class一直报错
    UIViewController *editorViewController = [[self.router class] viewForCreatingNoteWithDelegate:delegate];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editorViewController];
    NSLog(@"routeSoure = %@ , editorVC = %@", [self.view.routeSource class], [editorViewController class]);
    //  routeSoure = YFNoteListViewController , editorVC = (null)
    [[self.router class] presentViewController:navigationController fromViewController:self.view.routeSource animated:YES completion:completion];
    [self resetState];
    self.editor = editorViewController;
//    self.presentingEditor = YES;
}

- (void)resetState {
//    self.editor = nil;
//    self.presentingEditor = NO;
//    self.pushedEditor = NO;
}

@end
