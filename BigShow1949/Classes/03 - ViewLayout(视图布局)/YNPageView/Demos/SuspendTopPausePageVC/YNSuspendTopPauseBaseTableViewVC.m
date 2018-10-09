//
//  YNSuspendTopPauseBaseTableViewVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/7/14.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendTopPauseBaseTableViewVC.h"
#import "MJRefresh.h"
#import "BaseViewController.h"
#import "UIViewController+YNPageExtend.h"
#import "YNPageTableView.h"

#define kCellHeight 44

@interface YNSuspendTopPauseBaseTableViewVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YNSuspendTopPauseBaseTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    [self.view addSubview:self.tableView];
    
    _dataArray = @[].mutableCopy;
    /// 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 420; i++) {
            [_dataArray addObject:@""];
        }
        [self.tableView reloadData];
    });
    [self addTableViewRefresh];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView setContentOffset:CGPointMake(0, 240)];
//    });
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)addTableViewRefresh {
    
    __weak typeof (self) weakSelf = self;
    
    /// 这里加 footer 刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < 30; i++) {
                [weakSelf.dataArray addObject:@""];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
    
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.dataArray.count) {
        return kCellHeight;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (indexPath.row < self.dataArray.count) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ section: %zd row:%zd", self.cellTitle ?: @"测试", indexPath.section, indexPath.row];
        return cell;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseViewController *baseVC = [BaseViewController new];
    baseVC.title = @"二级页面";
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[YNPageTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
