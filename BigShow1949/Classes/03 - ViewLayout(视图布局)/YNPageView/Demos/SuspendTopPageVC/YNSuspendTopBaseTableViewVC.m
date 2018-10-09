//
//  YNSuspendTopBaseTableViewVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/25.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendTopBaseTableViewVC.h"
#import "MJRefresh.h"
#import "UIViewController+YNPageExtend.h"

/// 开启刷新头部高度
#define kOpenRefreshHeaderViewHeight 1

@interface YNSuspendTopBaseTableViewVC ()

@end

@implementation YNSuspendTopBaseTableViewVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (kOpenRefreshHeaderViewHeight) {
        if (self.tableView.mj_header.ignoredScrollViewContentInsetTop != self.yn_pageViewController.config.tempTopHeight) {
            [self addTableViewRefresh];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/// 重写父类方法 添加 刷新方法
- (void)addTableViewRefresh {
    
    __weak typeof (self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (kOpenRefreshHeaderViewHeight) {
                [weakSelf suspendTopReloadHeaderViewHeight];
            } else {
                [weakSelf.tableView.mj_header endRefreshing];
            }
        });
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
    
    /// 需要设置下拉刷新控件UI的偏移位置
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = self.yn_pageViewController.config.tempTopHeight;
}

#pragma mark - 悬浮Top刷新高度方法
- (void)suspendTopReloadHeaderViewHeight {
    
    /// 布局高度
    CGFloat netWorkHeight = 900;
    __weak typeof (self) weakSelf = self;
    
    /// 结束刷新时 刷新 HeaderView高度
    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
        YNPageViewController *VC = weakSelf.yn_pageViewController;
        if (VC.headerView.frame.size.height != netWorkHeight) {
            VC.headerView.frame = CGRectMake(0, 0, YFScreen.width, netWorkHeight);
            [VC reloadSuspendHeaderViewFrame];
            [weakSelf addTableViewRefresh];
        }
    }];
    
}


@end
