//
//  OneViewController.m
//  JLRoutes
//
//  Created by 孟遥 on 2017/3/27.
//  Copyright © 2017年 mengyao. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"第一模块";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:1];
    btn.frame = CGRectMake(100, 200, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jump
{
    NSString *url = JLRoutesJumpUrl(@"JLRoutesOne", @"OnePushViewController", @"123", nil, nil, nil);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
}

@end
