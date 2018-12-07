//
//  YFToDoRouter.m
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoRouter.h"
#import "YFToDoViewController.h"
#import "YFToDoInteractor.h"
#import "YFToDoPresenter.h"

@implementation YFToDoRouter
+ (YFToDoViewController *)createModule
{
    NSString *viewName = NSStringFromClass([YFToDoViewController class]);
    YFToDoViewController *viewController = [[YFToDoViewController alloc] initWithNibName:viewName bundle:nil];
    YFToDoInteractor *interactor = [[YFToDoInteractor alloc] init];
    YFToDoRouter *router = [[YFToDoRouter alloc] init];
    YFToDoPresenter *presenter = [[YFToDoPresenter alloc] initWithInterface:viewController interactor:interactor router:router];
    viewController.presenter = presenter;
    router.viewController = viewController;
    return viewController;
}
@end
