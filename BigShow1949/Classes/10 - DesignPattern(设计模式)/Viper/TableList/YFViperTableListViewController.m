//
//  YFViperTableListViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFViperTableListViewController.h"
#import "YFCategoryTableWireframe.h"
#import "YFCategoryTablePresenter.h"
#import "YFCategoryTableInteractor.h"
#import "YFCategoryTableViewController.h"

@interface YFViperTableListViewController ()
//@property (nonatomic, strong) YFCategoryTableWireframe *wireframe;
//@property (nonatomic, strong) YFCategoryTableViewController *viewController;


@end

@implementation YFViperTableListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureDependencies];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *redBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 44)];
    [redBtn setTitle:@"Button" forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    redBtn.titleLabel.textColor = [UIColor blackColor];
    redBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:redBtn];
}


- (void)configureDependencies {
    /*
     //    CBCategoryTableViewController *categoryController = [CBCategoryTableViewController new];
     CBCategoryTablePresenter *categoryPresenter = [CBCategoryTablePresenter new];
     CBCategoryTableWireframe *categoryWireframe = [CBCategoryTableWireframe new];
     CBCategoryTableInteractor *categoryInteractor = [CBCategoryTableInteractor new];
     //    categoryController.presenter = categoryPresenter;
     categoryPresenter.wireframe = categoryWireframe;
     categoryWireframe.presenter = categoryPresenter;
     categoryPresenter.interactor = categoryInteractor;
     self.categoryWireframe = categoryWireframe;
     */
}

- (void)buttonClick {
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
}

@end
