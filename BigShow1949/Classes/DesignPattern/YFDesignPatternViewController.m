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

    self.titles = @[@"MVVM_coderyi",
                    @"DataSource分离"];
    
    self.classNames = @[@"YiTableViewController",
                        @"MyDataSourceViewController"];

}



@end
