//
//  YFCategoryTableWireframe.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFCategoryTableWireframe.h"
#import "YFCategoryTableViewController.h"

@implementation YFCategoryTableWireframe

- (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source {
    [source.navigationController pushViewController:destination animated:YES];
}

- (void)jumpToNews:(int)categoryIndex {
    
    // 点击跳转在这里做，类似于下面的结构
    /*
     
     YFCategoryTableViewController *viewController = [[YFCategoryTableViewController alloc] init];
     YFCategoryTablePresenter *presenter = [YFCategoryTablePresenter new];
     YFCategoryTableWireframe *wireframe = [YFCategoryTableWireframe new];
     YFCategoryTableInteractor *interactor = [YFCategoryTableInteractor new];
     presenter.wireframe = wireframe;
     presenter.interactor = interactor;
     presenter.categoryView = viewController;
     wireframe.presenter = presenter;
     viewController.presenter = presenter;
     
     [wireframe pushViewController:viewController fromViewController:self];
     */
}
@end
