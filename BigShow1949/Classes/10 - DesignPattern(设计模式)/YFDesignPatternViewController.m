//
//  YFDesignPatternViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFDesignPatternViewController.h"

@interface YFDesignPatternViewController ()

@end

@implementation YFDesignPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"MVVM_coderyi",@"YiTableViewController"],
                         @[@"DataSource分离",@"MyDataSourceViewController"],
                         @[@"MVP登录",@"MVPLoginViewController"],
                         @[@"MVP登录2",@"MVPLogin2ViewController_UIStoryboard"],
                         @[@"MVP计数器",@"MVPCounterViewController"],
                         @[@"MVP Home",@"MVPHomeViewController"],
                         @[@"Router跳转",@"YFRouterViewController"],
                         @[@"VIPER",@"YFVIPERViewController"]]]; // 先写在这里，以后再分
    
}



@end
