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

    self.titles = @[@"水平滚动布局",
                    @"瀑布流布局",
                    @"浏览卡",
                    @"半圆布局",
                    @"滑动标题",
                    @"网易滑动标题",
                    @"抽卡效果"];
    
    self.classNames = @[@"YFHorizontalScrollViewController",
                        @"YFWaterflowViewController",
                        @"RGCardLayoutViewController_UIStoryboard",
                        @"YFHalfCircleLayoutViewController_UIStoryboard",
                        @"YFSlideTitlesViewController",
                        @"YFNeteaseHomeViewController",
                        @"YFStackedPageVC_UIStoryboard"];
}



@end
