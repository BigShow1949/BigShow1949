//
//  MyDataSourceViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MyDataSourceViewController.h"
#import "MyDataSource.h"
#import "SecondTableViewCell.h"

@interface MyDataSourceViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MyDataSource *datasource;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MyDataSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, 320, 568);
    tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // dataArray
    self.dataArray = @[@"test1", @"test2", @"test3", @"test4"];
    
    //cell数据的填充方法
    void (^myCallBackBlock)(id cell , id data) = ^(id cell ,id data){ // 相当于cellForRow
        
        SecondTableViewCell *cell2 = (SecondTableViewCell *)cell;
        [cell2 setDataByModel:data];
    };
    
    _datasource = [[MyDataSource alloc]initWithItems:_dataArray cellIdentifier:@"SecondTableViewCell" andCallBack:myCallBackBlock];
    _tableView.dataSource = _datasource;
    [_tableView reloadData];
}


@end
