//
//  YNTopPageVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNTopPageVC.h"
#import "BaseTableViewVC.h"

@interface YNTopPageVC () <YNPageViewControllerDelegate, YNPageViewControllerDataSource>

@end

@implementation YNTopPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (instancetype)topPageVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
        configration.pageStyle = YNPageStyleTop;
    configration.headerViewCouldScale = YES;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = NO;
    configration.showBottomLine = YES;
    
    
    YNTopPageVC *vc = [YNTopPageVC pageViewControllerWithControllers:[self getArrayVCs]
                                                              titles:[self getArrayTitles]
                                                              config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    
    return vc;
}


+ (NSArray *)getArrayVCs {
    
    BaseTableViewVC *vc_1 = [[BaseTableViewVC alloc] init];
    vc_1.cellTitle = @"鞋子";
    
    BaseTableViewVC *vc_2 = [[BaseTableViewVC alloc] init];
    vc_2.cellTitle = @"衣服";
    
    BaseTableViewVC *vc_3 = [[BaseTableViewVC alloc] init];
    vc_3.cellTitle = @"帽子";
    
    return @[vc_1, vc_2, vc_3];
}

+ (NSArray *)getArrayTitles {
    return @[@"鞋子", @"衣服", @"帽子"];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    BaseTableViewVC *baseVC = pageViewController.controllersM[index];
    return [baseVC tableView];
}

@end
