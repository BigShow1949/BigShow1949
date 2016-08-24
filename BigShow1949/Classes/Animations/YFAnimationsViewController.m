//
//  YFAnimationsViewController.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFAnimationsViewController.h"


@implementation YFAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[@"弹出菜单动画",
                    @"粒子发射器",
                    @"水纹",
                    @"渐变色和贝塞尔曲线",
                    @"核心动画",
                    @"抖动密码框"];
    
    self.classNames = @[@"YFPopMenuViewController",
                        @"YFEmitterViewController",
                        @"YFWaterWaveViewController",
                        @"YFBezierViewController",
                        @"YFCoreAnimationViewController",
                        @"YFPasswordShakeViewController"];
}


@end
