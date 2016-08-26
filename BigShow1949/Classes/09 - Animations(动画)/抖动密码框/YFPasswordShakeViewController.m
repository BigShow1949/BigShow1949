//
//  YFPasswordShakeViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFPasswordShakeViewController.h"
#import "UITextField+Shake.h"

@interface YFPasswordShakeViewController ()
@property (nonatomic, strong) UITextField *textField;

@end

@implementation YFPasswordShakeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.text = @"textField";
    textField.frame = CGRectMake(50, 100, 100, 30);
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1.0f;
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton *redBtn = [[UIButton alloc] init];
    redBtn.frame = CGRectMake(100, 200, 100, 100);
    [redBtn setTitle:@"click here" forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(redBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    redBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:redBtn];
    
}

- (void)redBtnClick:(UIButton *)redBtn {
    [self.textField shakeWithCompletion:^{
        NSLog(@"密码框抖动动画完成");
    }];
}


@end
