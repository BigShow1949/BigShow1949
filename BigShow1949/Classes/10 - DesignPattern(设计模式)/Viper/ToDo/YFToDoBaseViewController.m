//
//  YFToDoBaseViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoBaseViewController.h"
// List
#import "YFToDoWireframe.h"
#import "YFToDoInteractor.h"
#import "YFToDoPresenter.h"
#import "YFToDoViewController.h"

@interface YFToDoBaseViewController ()
@property (nonatomic, strong) YFToDoWireframe *wireframe;
@property (nonatomic, strong) YFToDoViewController *viewController;

@end

@implementation YFToDoBaseViewController

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

- (void)buttonClick {
    [self.wireframe pushViewController:self.viewController fromViewController:self];
}

- (void)configureDependencies {
    
    YFToDoViewController *viewController = [[YFToDoViewController alloc] init];
    YFToDoPresenter *presenter = [YFToDoPresenter new];
    YFToDoWireframe *wireframe = [YFToDoWireframe new];
    YFToDoInteractor *interactor = [YFToDoInteractor new];
    presenter.wireframe = wireframe;
    presenter.interactor = interactor; // 这里没有强指针指向 interactor，所以 presenter.interactor是强指针，地下的output是肉指针，不会循环引用
    presenter.viewController = viewController;
    
    interactor.output = presenter;
    wireframe.presenter = presenter;
    viewController.presenter = presenter;
    
    self.wireframe = wireframe;
    self.viewController = viewController;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
