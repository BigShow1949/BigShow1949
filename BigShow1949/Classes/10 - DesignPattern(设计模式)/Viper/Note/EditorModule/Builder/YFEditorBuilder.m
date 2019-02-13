//
//  YFEditorBuilder.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFEditorBuilder.h"
#import "YFEditorViewController.h"
#import "YFEditorViewPresenter.h"
#import "YFEditorInteractor.h"
#import "YFEditorWireframe.h"

#import "YFViperViewPrivate.h"
#import "YFViperInteractorPrivate.h"
#import "YFViperPresenterPrivate.h"
#import "YFNoteModel.h"

#import "YFViperPresenterPrivate.h"

#import "NSObject+YFViperAssembly.h"

@implementation YFEditorBuilder
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<YFEditorDelegate>)delegate router:(id<YFViperRouter>)router {
    YFEditorViewController *view = [[YFEditorViewController alloc] init];
    view.delegate = delegate;
    view.editMode = YFEditorModeCreate;
    [self buildView:(id<YFViperViewPrivate>)view note:nil router:router];
    return view;
}

+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<YFEditorDelegate>)delegate router:(id<YFViperRouter>)router {
    YFEditorViewController *view = [[YFEditorViewController alloc] init];
    view.delegate = delegate;
    view.editMode = YFEditorModeModify;
    
    YFNoteModel *note = [[YFNoteModel alloc] initWithUUID:uuid title:title content:content];
    [self buildView:view note:note router:router];
    
    return view;
}

+ (void)buildView:(id<YFViperViewPrivate>)view note:(nullable YFNoteModel *)note router:(id<YFViperRouter>)router {
//    YFEditorViewPresenter *presenter = [[YFEditorViewPresenter alloc] init];
    id<YFViperPresenterPrivate>presenter = (id)[[YFEditorViewPresenter alloc] init];

    YFEditorInteractor *interactor = [[YFEditorInteractor alloc] initWithEditingNote:note];
    id<YFViperWireframePrivate> wireframe = (id)[[YFEditorWireframe alloc] init];
    
    // 不调用这个方法了，里面各种报错
    [self assembleViperForView:view
                     presenter:(id<YFViperPresenterPrivate>)presenter
                    interactor:(id<YFViperInteractorPrivate>)interactor
                     wireframe:(id<YFViperWireframePrivate>)wireframe
                        router:(id<YFViperRouter>)router];
    
//    interactor.eventHandler = presenter;
//    interactor.dataSource = presenter;
//
//    wireframe.view = view;
//    wireframe.router = router;
//
//    [presenter setInteractor:interactor];
//    [presenter setView:view];
//    [presenter setWireframe:wireframe];
//
//    view.eventHandler = presenter;
}





























@end
