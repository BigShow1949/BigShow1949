//
//  ModuleBRootViewController.m
//  EcoRouterDemo
//
//  Created by 陈磊 on 2017/3/5.
//  Copyright © 2017年 chenlei. All rights reserved.
//

#import "ModuleBRootViewController.h"
#import "EcoRouterTool.h"

@interface ModuleBRootViewController ()

@end

@implementation ModuleBRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ModuleB_Root";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)actionGo
{
    [EcoRouterTool openClass:@"ModuleBViewController" withUserInfo:nil from:self.navigationController];
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
