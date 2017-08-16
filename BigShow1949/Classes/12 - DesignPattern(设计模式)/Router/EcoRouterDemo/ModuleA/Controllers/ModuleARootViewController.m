//
//  ModuleARootViewController.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleARootViewController.h"
#import "EcoRouterTool.h"

@interface ModuleARootViewController ()

@end

@implementation ModuleARootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ModuleA_Root";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///跳转
- (void)actionGo
{
    [EcoRouterTool openClass:@"ModuleAViewController" withUserInfo:nil from:self.navigationController];
}


@end
