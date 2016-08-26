//
//  YFScrollViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/14.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFScrollViewController.h"

@interface YFScrollViewController ()

@end

@implementation YFScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[@"放大头部视图",
                    @"UITableView全选删除",
                    @"UITableViewCell多级视图"];
    
    self.classNames = @[@"YFBlurtViewController",
                        @"YFTableViewDelAll",
                        @"RootViewController_xib"];
}


@end
