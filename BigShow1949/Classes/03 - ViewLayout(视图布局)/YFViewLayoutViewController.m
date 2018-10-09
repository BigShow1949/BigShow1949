//
//  YFViewLayoutViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFViewLayoutViewController.h"

@interface YFViewLayoutViewController ()

@end

@implementation YFViewLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDataArr:@[@[@"水平滚动布局",@"YFHorizontalScrollViewController"],
                         @[@"瀑布流布局",@"YFWaterflowViewController"],
                         @[@"浏览卡",@"RGCardLayoutViewController_UIStoryboard"],
                         @[@"半圆布局",@"YFHalfCircleLayoutViewController_UIStoryboard"],
                         @[@"滑动标题",@"YFSlideTitlesViewController"],
                         @[@"网易滑动标题",@"YFNeteaseHomeViewController"],
                         @[@"抽卡效果",@"YFStackedPageVC_UIStoryboard"],
                         @[@"YNPageView",@"YNPageViewDemoController"],
                         @[@"ArtPageView",@"ArtPageViewController"]]];
}



@end
