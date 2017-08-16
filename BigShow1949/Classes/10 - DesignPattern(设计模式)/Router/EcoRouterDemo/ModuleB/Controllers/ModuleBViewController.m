//
//  TestAViewController.m
//  RouterTest
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleBViewController.h"
#import "EcoRouterTool.h"

@implementation ModuleBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ModuleB_界面B";
    // Do any additional setup after loading the view.
}

- (void)setNavBarItem
{
    [self addRightItem];
}

///跳转
- (void)actionGo
{
    [EcoRouterTool openClass:@"ModuleAViewController" withUserInfo:@{@"key1":@"1",@"key2":@"2"} from:self.navigationController];
}

@end
