//
//  MVPLogin2ViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "MVPLogin2ViewController.h"
#import "DemoPresenter.h"
#import "DemoViewModel.h"

@interface MVPLogin2ViewController ()<DemoViewProrocol>
@property (nonatomic, strong) IBOutlet UITextField* userNameField;
@property (nonatomic, strong) IBOutlet UITextField* passwordField;
- (IBAction) submitButtonTapped:(id) sender;

@property (nonatomic, weak) id<DemoPresenterProtocol>presenterDelegate;
@end

@implementation MVPLogin2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    DemoPresenter *presenter = [[DemoPresenter alloc] init];
    presenter.viewDelegate = self;
    self.presenterDelegate = presenter;
}


- (IBAction)submitButtonTapped:(id)sender
{
    DemoViewModel* viewModel = [[DemoViewModel alloc] init];
    viewModel.userName = self.userNameField.text;
    viewModel.password = self.passwordField.text;
    
    [self.presenterDelegate doLoginRequest:viewModel];
}


#pragma mark - DemoViewProrocol Methods
- (void) showPasswordInvalidInfo
{
    NSLog(@"密码错误");
}

- (void) onRequestStart
{
    NSLog(@"网络开始");
}

- (void) onRequestSuccess
{
    NSLog(@"网络结束");
}

- (void) onRequestError
{
    
}

@end
