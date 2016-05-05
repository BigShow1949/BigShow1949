//
//  DataListController.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/1.
//  Copyright © 2015年 LccLcc. All rights reserved.
//  表界面

#import <UIKit/UIKit.h>

@interface DataListController : UIViewController

//表名
@property(nonatomic,strong)NSString *sheetTitle;
//表的字段
@property(nonatomic,strong)NSArray *attributesArray;
//表视图
@property(nonatomic,strong)UITableView *tableView;

@end
