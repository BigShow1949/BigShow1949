//
//  YNSuspendCustomNavOrSuspendPositionVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/7/19.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNSuspendCustomNavOrSuspendPositionVC.h"
#import "YNPageViewController.h"
#import "UIView+YNPageExtend.h"
#import "BaseTableViewVC.h"
#import "BaseCollectionViewVC.h"
#import "SDCycleScrollView.h"
#import "UIColor+Extension.h"

@interface YNSuspendCustomNavOrSuspendPositionVC () <YNPageViewControllerDataSource, YNPageViewControllerDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, copy) NSArray *imagesURLs;

@property (nonatomic, strong) UIView *navView;

@end

@implementation YNSuspendCustomNavOrSuspendPositionVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.frame = CGRectMake(0, 0, 80, 80);
    _indicatorView.center = self.view.center;
    [_indicatorView startAnimating];
    
    /// 模拟器请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self setupPageVC];
        
        [_indicatorView stopAnimating];
        [_indicatorView setHidden:YES];
    });
    
    [self.view addSubview:_indicatorView];
}

- (void)setupPageVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    /// 控制tabbar 和 nav
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    /// 设置悬浮停顿偏移量
    configration.suspenOffsetY = kYNPAGE_NAVHEIGHT;
    
    
    YNPageViewController *vc = [YNPageViewController pageViewControllerWithControllers:self.getArrayVCs
                                                                                titles:[self getArrayTitles]
                                                                                config:configration];
    vc.dataSource = self;
    vc.delegate = self;
    /// 轮播图 YFScreen.width
    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, YFScreen.width, 200) imageURLStringsGroup:self.imagesURLs];
    autoScrollView.delegate = self;
    
    vc.headerView = autoScrollView;
    /// 指定默认选择index 页面
    vc.pageIndex = 2;
    
    
    /// 作为自控制器加入到当前控制器
    [vc addSelfToParentViewController:self];
    
    /// 如果隐藏了导航条可以 适当改y值
//    pageVC.view.yn_y = kYNPAGE_NAVHEIGHT;
    
    [self.view addSubview:self.navView];
    
}

- (NSArray *)getArrayVCs {
    
    BaseTableViewVC *vc_1 = [[BaseTableViewVC alloc] init];
    vc_1.cellTitle = @"鞋子";
    
    BaseTableViewVC *vc_2 = [[BaseTableViewVC alloc] init];
    vc_2.cellTitle = @"衣服";
    
    BaseCollectionViewVC *vc_3 = [[BaseCollectionViewVC alloc] init];
    
    return @[vc_1, vc_2, vc_3];
}

- (NSArray *)getArrayTitles {
    return @[@"鞋子", @"衣服", @"帽子"];
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YFScreen.width, kYNPAGE_NAVHEIGHT)];
//        _navView.backgroundColor = RGB_COLOR(246, 246, 246, 0);
    }
    return _navView;
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
    if ([vc isKindOfClass:[BaseTableViewVC class]]) {
        return [(BaseTableViewVC *)vc tableView];
    } else {
        return [(BaseCollectionViewVC *)vc collectionView];
    }
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
    NSLog(@"--- contentOffset = %f, progress = %f", contentOffset, progress);
    
//    self.navView.backgroundColor = RGBA(246, 246, 246, progress);
    
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"----click 轮播图 index %ld", index);
}


@end
