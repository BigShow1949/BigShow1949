//
//  MyDataSourceViewController2.m
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MyDataSourceViewController2.h"
#import "DataSource2.h"
#import "SecondTableViewCell.h"
#import "ModelTwo.h"

@interface MyDataSourceViewController2 ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DataSource2 *datasource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MyDataSourceViewController2

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
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SecondTableViewCell class])];
    
    __weak __typeof(self) weakSelf = self;
    
    // cell事件
    YFCellSelectedBlock cellSelectedBlock = ^(id obj){
        
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        // cell点击事件
        [strongSelf cellSelectedWithObj:obj];
    };
    
    YFCellBackBlock cellBackBlock = ^(id cell , id data){ // 或者在子类DataSource重写cellForRow
        
        SecondTableViewCell *cell2 = (SecondTableViewCell *)cell;
        cell2.backgroundColor = [UIColor blueColor];
    };
    
    // 初始化dataSource
    _datasource = [[DataSource2 alloc] initWithServerData:_dataArray
                                        andCellIdentifier:NSStringFromClass([SecondTableViewCell class])];
    _datasource.cellSelectedBlock = cellSelectedBlock;
    _datasource.cellBackBlock = cellBackBlock;
}

- (void)configData
{
    // 服务器返回的数据
    _dataArray = [[NSMutableArray alloc] init];
    // 实体设置
    ModelTwo *one = [[ModelTwo alloc] init];
    ModelTwo *two = [[ModelTwo alloc] init];
    
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
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark -
#pragma mark - Action
- (void)cellSelectedWithObj:(id)obj
{
    NSLog(@"%@",obj);
//    MyDataSourceViewController2 *vc2 = [[MyDataSourceViewController2 alloc] init];
//    [self.navigationController pushViewController:vc2 animated:YES];
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = CGRectMake(0, 0, YFScreen.width, YFScreen.height);
        tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

@end
