//
//  BaseVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "BaseTableViewVC.h"
#import "MJRefresh.h"
#import "BaseViewController.h"
#import "UIViewController+YNPageExtend.h"

/// 开启刷新头部高度
#define kOpenRefreshHeaderViewHeight 0

#define kCellHeight 44

@interface BaseTableViewVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
/// 占位cell高度
@property (nonatomic, assign) CGFloat placeHolderCellHeight;

@end

@implementation BaseTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    [self.view addSubview:self.tableView];
    
    _dataArray = @[].mutableCopy;
    /// 加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 30; i++) {
            [_dataArray addObject:@""];
        }
        [self.tableView reloadData];
    });
    [self addTableViewRefresh];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
//     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView.mj_header beginRefreshing];
//    });
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

/// 添加下拉刷新
- (void)addTableViewRefresh {
    
    __weak typeof (self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            for (int i = 0; i < 3; i++) {
                [weakSelf.dataArray addObject:@""];
            }
            [weakSelf.tableView reloadData];
            if (kOpenRefreshHeaderViewHeight) {
                [weakSelf suspendTopReloadHeaderViewHeight];
            } else {
                [weakSelf.tableView.mj_header endRefreshing];
            }

        });
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < 3; i++) {
                [weakSelf.dataArray addObject:@""];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

#pragma mark - 悬浮Center刷新高度方法
- (void)suspendTopReloadHeaderViewHeight {
    /// 布局高度
    CGFloat netWorkHeight = 300;
    __weak typeof (self) weakSelf = self;
    
    /// 结束刷新时 刷新 HeaderView高度
    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
        YNPageViewController *VC = weakSelf.yn_pageViewController;
        if (VC.headerView.frame.size.height != netWorkHeight) {
            VC.headerView.frame = CGRectMake(0, 0, YFScreen.width, netWorkHeight);
            [VC reloadSuspendHeaderViewFrame];
        }
    }];
}
#pragma mark - 求出占位cell高度
- (CGFloat)placeHolderCellHeight {
    CGFloat height = self.config.contentHeight - kCellHeight * self.dataArray.count;
    height = height < 0 ? 0 : height;
    return height;
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
    
    return self.dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.dataArray.count) {
        return kCellHeight;
    }
    return self.placeHolderCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (indexPath.row < self.dataArray.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ section: %zd row:%zd", self.cellTitle ?: @"测试", indexPath.section, indexPath.row];
        return cell;
    } else {
        cell.textLabel.text = @"";
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"----- %@ delloc", self.class);
}

@end
