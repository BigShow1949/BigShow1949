//
//  YFRouterViewController.m
//  BigShow1949
//
//  Created by apple on 17/8/16.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "YFRouterViewController.h"

@interface YFRouterViewController ()

@end

@implementation YFRouterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"EcoRouter",@"EcoMainViewController"],
                         @[@"JLRouters",@"JLRoutersTabbarController"]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
