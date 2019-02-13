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
#import "YFRouter+YFLogin.h"

// YFViperWireframePrivate 遵守这个协议有啥用，提示view跟router赋值？
@interface YFNoteListWireframe()<YFViperWireframePrivate>
@property (nonatomic, weak) id<YFViperView> view;
//@property (nonatomic, strong) id<YFNoteListRouter> router;
@property (nonatomic, strong) id router; // 加这个就报错<YFNoteListRouter>
@property (nonatomic, weak) UIViewController *editor;
@property (nonatomic, assign) BOOL presentingEditor;
@property (nonatomic, assign) BOOL pushedEditor;

@end

@implementation YFNoteListWireframe

#pragma mark - YFNoteListWireframeInput
- (void)presentEditorForCreatingNewNoteWithDelegate:(id<YFEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion {

    UIViewController *editorViewController = [[self.router class] viewForCreatingNoteWithDelegate:delegate];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editorViewController];
    NSLog(@"routeSoure = %@ , editorVC = %@", [self.view.routeSource class], [editorViewController class]);
    [[self.router class] presentViewController:navigationController fromViewController:self.view.routeSource animated:YES completion:completion];
    [self resetState];
    self.editor = editorViewController;
    self.presentingEditor = YES;
}

- (void)quitEditorViewWithAnimated:(BOOL)animated {
    if (self.presentingEditor) {
        self.presentingEditor = NO;
        [[self.router class] dismissViewController:self.editor animated:animated completion:nil];
    } else if (self.pushedEditor) {
        self.pushedEditor = NO;
        [[self.router class] popViewController:self.editor animated:animated];
    }
}

- (void)pushEditorViewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<YFEditorDelegate>)delegate {
    UIViewController *editorViewController = [[self.router class] viewForEditingNoteWithUUID:uuid title:title content:content delegate:delegate];
    //  editorViewController = (null), routerSource = <YFNoteListViewController: 0x7fcd26d3c6e0>
    NSLog(@"editorViewController = %@, routerSource = %@", editorViewController, self.view.routeSource);
    [[self.router class] pushViewController:editorViewController fromViewController:self.view.routeSource animated:YES];
    [self resetState];
    self.editor = editorViewController;
    self.pushedEditor = YES;
}

- (void)presentLoginViewWithMessage:(NSString *)message delegate:(id<YFLoginViewDelegate>)delegate completion:(void (^ __nullable)(void))completion {
    UIViewController *loginViewController = [[self.router class] loginViewWithMessage:message delegate:delegate];
    NSLog(@"routeSource = %@", self.view.routeSource);
    [[self.router class] presentViewController:loginViewController fromViewController:self.view.routeSource animated:YES completion:completion];
}

- (void)resetState {
    self.editor = nil;
    self.presentingEditor = NO;
    self.pushedEditor = NO;
}

@end
