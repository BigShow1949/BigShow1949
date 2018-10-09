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

    
    [self setupDataArr:@[@[@"百度视图切换",@"YFBaiduViewTransitionViewController"],
                         @[@"领英动画",@"RZSimpleViewController_UIStoryboard"],
                         @[@"LTSlidingTransitions",@"YFSlidingViewController_UIStoryboard"],
                         @[@"折卡效果",@"YFFlipPageViewController"],
                         @[@"卡牌拖动翻页",@"YFDraggableCardViewController"],
                         @[@"侧滑形变效果",@"YFITRAirSideViewController"],]];
    
}


@end
