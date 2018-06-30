//
//  YFToolsViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/31.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFToolsViewController.h"

@interface YFToolsViewController ()

@end

@implementation YFToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"颜色转换",@"YFColorViewController_UIStoryboard"],
                         @[@"图片",@"YFImageCategoryViewController"],
                         @[@"无数据界面提示",@"YFEmptyDataSetViewController_UIStoryboard"],
                         @[@"按钮",@"YFButtonCategoryViewController"],
                         @[@"崩溃过滤",@"YFSafeObjectViewController"],]];

}



@end
