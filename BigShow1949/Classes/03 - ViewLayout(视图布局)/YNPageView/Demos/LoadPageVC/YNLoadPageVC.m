//
//  LoadPageVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/26.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNLoadPageVC.h"
#import "YNPageViewController.h"
#import "YNSuspendCenterPageVC.h"
#import "YNTopPageVC.h"
#import "UIView+YNPageExtend.h"

/// 是否隐藏导航条
#define kHiddenNavigationBar 1

@interface YNLoadPageVC ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation YNLoadPageVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (kHiddenNavigationBar) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (kHiddenNavigationBar) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
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
    //    configration.headerViewScaleMode = YNPageHeaderViewScaleModeCenter;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    /// 控制tabbar 和 nav
    configration.showTabbar = NO;
    configration.showNavigation = NO;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    configration.suspenOffsetY = 64;
    YNSuspendCenterPageVC *pageVC = [YNSuspendCenterPageVC suspendCenterPageVCWithConfig:configration];
    
    /// 作为自控制器加入到当前控制器
    [pageVC addSelfToParentViewController:self];
    
    /// 如果隐藏了导航条可以 适当改y值
    if (kHiddenNavigationBar) {
//        pageVC.view.yn_y = kYNPAGE_NAVHEIGHT;
    }
    
    
}

@end
