//
//  MyDataSourceViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MyDataSourceViewController.h"
#import "MyDataSourceViewController2.h"
#import "DataSource1.h"
#import "OneTableViewCell.h"
#import "ModelOne.h"

@interface MyDataSourceViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataSource1 *datasource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyDataSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化datasource
    [self configDataSource];
    
    // 初始化tableview
    [self configTableView];
    
}

- (void)configDataSource
{
    // cell数据
    [self configData];
    
    // cell复用
//     [self.tableView registerNib:[OneTableViewCell nib] forCellReuseIdentifier:NSStringFromClass([TCellOne class])];
    [self.tableView registerClass:[OneTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OneTableViewCell class])];
    
    __weak __typeof(self) weakSelf = self;
    
    // cell事件
    YFCellSelectedBlock cellSelectedBlock = ^(id obj){  // cell点击
        
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        MyDataSourceViewController2 *vc2 = [[MyDataSourceViewController2 alloc] init];
        [strongSelf.navigationController pushViewController:vc2 animated:YES];
    };
    
    // 初始化dataSource
    _datasource = [[DataSource1 alloc] initWithServerData:_dataArray
                                        andCellIdentifier:NSStringFromClass([OneTableViewCell class])];
    _datasource.cellSelectedBlock = cellSelectedBlock;
}

- (void)configData
{
    // 服务器返回的数据
    _dataArray = [[NSMutableArray alloc] init];
    // 实体设置
    ModelOne *one = [[ModelOne alloc] init];
    ModelOne *two = [[ModelOne alloc] init];
    
    one.name = @"奇犽";
    two.name = @"拿尼加";

    
    [_dataArray addObject:one];
    [_dataArray addObject:two];
}

- (void)configTableView
{
    // 把_dataSource设置成_tableview的代理,以后所有代理方法都在_dataSource实现
    self.tableView.delegate = _datasource;
    self.tableView.dataSource = _datasource;
}





- (UITableView *)tableView {

    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = CGRectMake(0, 0, YFScreen.width, YFScreen.height);
        tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
