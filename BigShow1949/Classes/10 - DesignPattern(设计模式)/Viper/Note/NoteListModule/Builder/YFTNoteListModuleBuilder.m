//
//  YFTNoteListModuleBuilder.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFTNoteListModuleBuilder.h"
#import "YFNoteListInteractor.h"
#import "YFNoteListViewPresenter.h"
#import "YFNoteListViewController.h"
#import "YFNoteListWireframe.h"

#import "YFViperViewPrivate.h"

// 先临时写在这里
#import "YFViperWireframePrivate.h"
#import "YFViperPresenterPrivate.h"

@implementation YFTNoteListModuleBuilder

+ (UIViewController *)viewControllerWithNoteListDataService:(id<YFViperViewPrivate>)service router:(id<YFNoteListRouter>)router {
    return nil;
}

+ (void)buildView:(id<YFViperViewPrivate>)view noteListDataService:(id<YFNoteListDataService>)service router:(id<YFNoteListRouter>)router {
    // 对传入的参数判断
    
    YFNoteListViewPresenter *presenter = [[YFNoteListViewPresenter alloc] init];
    YFNoteListInteractor *interactor = [[YFNoteListInteractor alloc] initWithNoteListDataService:service];
    interactor.eventHandler = presenter;
    interactor.dataSource = presenter;
    
    id<YFViperWireframePrivate>wireframe = (id)[[YFNoteListWireframe alloc] init];
    // view是weak，router是strong
    wireframe.view = view;
    wireframe.router = router;
    
    // view是weak，wireframe跟interactor是strong
    [(id<YFViperPresenterPrivate>)presenter setView:view];
    [(id<YFViperPresenterPrivate>)presenter setWireframe:wireframe];
    [(id<YFViperPresenterPrivate>)presenter setInteractor:interactor];
    
    // 这里强指针指向presenter，以免被释放
    view.eventHandler = presenter;
    view.viewDataSource = presenter;
    
}



@end





















