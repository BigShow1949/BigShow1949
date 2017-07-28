//
//  YFDataPersistenceViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/5.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFDataPersistenceViewController.h"

@interface YFDataPersistenceViewController ()

@end

@implementation YFDataPersistenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataArr:@[@[@"JKDBModel(错误)",@"JKDBViewController_UIStoryboard"],
                         @[@"FMDB基本使用",@"FMDBBaseUseViewController_UIStoryboard"],
                         @[@"SQLite基本使用",@"SQLiteBaseUseViewController_UIStoryboard"],
                         @[@"LCCSqliteManager",@"SheetListController"],]];
}


@end
