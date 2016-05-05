//
//  YFLittleProjectVC02.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-5.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFLittleProjectVC02.h"

#import "SYComposeViewController.h"

@interface YFLittleProjectVC02 ()

@end

@implementation YFLittleProjectVC02

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"发送表情" forState:UIControlStateNormal];
    btn.frame = CGRectMake(50, 200, 80, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    // 弹出发消息控制器
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    SYComposeViewController *compose = [[SYComposeViewController alloc] init];
    [rootVc presentViewController:[[UINavigationController alloc] initWithRootViewController:compose] animated:YES completion:nil];

}


@end
