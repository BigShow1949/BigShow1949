//
//  MVPLoginViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "MVPLoginViewController.h"
#import "LoginViewProtocol.h"
#import "LoginPresenter.h"

@interface MVPLoginViewController ()<LoginViewProtocol>
@property (nonatomic,strong) LoginPresenter* presenter;

@end

@implementation MVPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 模拟登录按钮点击
    UIButton *redBtn = [[UIButton alloc] init];
    redBtn.frame = CGRectMake(100, 100, 100, 100);
    [redBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    redBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:redBtn];
    
}

- (void)loginClick {
    _presenter = [[LoginPresenter alloc ]init];
    [_presenter attachView:self];
    //程序一旦运行立马执行请求(测试)(按钮或者事件)
    [_presenter loginWithName:@"18842693828" pwd:@"123456"];
}

- (void)onLoginResult:(NSString *)result{
    
    NSLog(@"返回结果 = %@",result);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_presenter detachView];
}

@end
