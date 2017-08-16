//
//  TestAViewController.m
//  RouterTest
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleAViewController.h"
#import "EcoRouterTool.h"

@implementation ModuleAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ModuleA_界面A";
    // Do any additional setup after loading the view.
}

- (void)setNavBarItem
{
    [self addRightItem];
}

///跳转
- (void)actionGo
{
    [EcoRouterTool openClass:@"ModuleBViewController" withUserInfo:nil from:self.navigationController];
}

@end
