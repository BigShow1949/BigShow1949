//
//  YNSuspendTopPausePageVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/7/14.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendTopPausePageVC.h"
#import "SDCycleScrollView.h"
#import "BaseTableViewVC.h"
#import "YNSuspendTopPauseBaseTableViewVC.h"
#import "MJRefresh.h"
#import "UIView+YNPageExtend.h"

#define kOpenRefreshHeaderViewHeight 0

@interface YNSuspendTopPausePageVC () <YNPageViewControllerDataSource, YNPageViewControllerDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, copy) NSArray *imagesURLs;

@end

@implementation YNSuspendTopPausePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//     [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

+ (instancetype)suspendTopPausePageVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionTopPause;
    configration.headerViewCouldScale = YES;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    
    YNSuspendTopPausePageVC *vc = [YNSuspendTopPausePageVC pageViewControllerWithControllers:[self getArrayVCs]
                                                                                      titles:[self getArrayTitles]
                                                                                      config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YFScreen.width, YFScreen.height)];
    headerView.layer.contents = (id)[UIImage imageNamed:@"mine_header_bg"].CGImage;
    /// 轮播图
    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, YFScreen.width, 200) imageURLStringsGroup:vc.imagesURLs];
    autoScrollView.delegate = vc;
    
    vc.headerView = autoScrollView;
    
//    vc.headerView = headerView;
    /// 指定默认选择index 页面
    vc.pageIndex = 1;
    
    __weak typeof(YNSuspendTopPausePageVC *) weakVC = vc;
    
    vc.bgScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSInteger refreshPage = weakVC.pageIndex;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            /// 取到之前的页面进行刷新 pageIndex 是当前页面
            YNSuspendTopPauseBaseTableViewVC *vc2 = weakVC.controllersM[refreshPage];
            [vc2.tableView reloadData];
            
            if (kOpenRefreshHeaderViewHeight) {
                weakVC.headerView.yn_height = 300;
                [weakVC.bgScrollView.mj_header endRefreshing];
                [weakVC reloadSuspendHeaderViewFrame];
            } else {
                [weakVC.bgScrollView.mj_header endRefreshing];
            }
        });
    }];
    
    return vc;
}

+ (NSArray *)getArrayVCs {
    
    YNSuspendTopPauseBaseTableViewVC *vc_1 = [[YNSuspendTopPauseBaseTableViewVC alloc] init];
    vc_1.cellTitle = @"鞋子";
    
    YNSuspendTopPauseBaseTableViewVC *vc_2 = [[YNSuspendTopPauseBaseTableViewVC alloc] init];
    vc_2.cellTitle = @"衣服";
    
    YNSuspendTopPauseBaseTableViewVC *vc_3 = [[YNSuspendTopPauseBaseTableViewVC alloc] init];
    vc_3.cellTitle = @"帽子";
    return @[vc_1, vc_2, vc_3];
}

+ (NSArray *)getArrayTitles {
    return @[@"鞋子", @"衣服", @"帽子"];
}

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (NSArray *)imagesURLs {
    if (!_imagesURLs) {
        _imagesURLs = @[
                        @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                        @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                        @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    }
    return _imagesURLs;
}
#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
    
    return [(YNSuspendTopPauseBaseTableViewVC *)vc tableView];
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
            NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"----click 轮播图 index %ld", index);
}

@end


