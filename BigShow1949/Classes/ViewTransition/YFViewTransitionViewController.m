//
//  YFViewTransitionViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/17.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFViewTransitionViewController.h"



@interface YFViewTransitionViewController ()

@end

@implementation YFViewTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.titles = @[@"百度视图切换",
                    @"领英动画",
                    @"LTSlidingTransitions",
                    @"折卡效果",
                    @"卡牌拖动翻页",
                    @"滚动悬浮视图",
                    @"侧滑形变效果"];
    
    
    self.classNames = @[@"YFBaiduViewTransitionViewController",
                        @"RZSimpleViewController_UIStoryboard",
                        @"YFSlidingViewController_UIStoryboard",
                        @"YFFlipPageViewController",
                        @"YFDraggableCardViewController",
                        @"YFHorizontalPagingViewController",
                        @"YFITRAirSideViewController"];

}


@end
