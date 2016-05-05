//
//  SheetListController.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/11/27.
//  Copyright © 2015年 LccLcc. All rights reserved.
//  主界面

#import <UIKit/UIKit.h>

@interface SheetListController : UIViewController

//存放数据库所有表名
@property(nonatomic,strong)NSArray *sheetListArray;

//表视图
@property(nonatomic,strong)UITableView *tableView;

@end
