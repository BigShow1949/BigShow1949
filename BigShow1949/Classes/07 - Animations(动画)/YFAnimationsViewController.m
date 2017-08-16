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

    [self setupDataArr:@[@[@"弹出菜单动画",@"YFPopMenuViewController"],
                         @[@"粒子发射器",@"YFEmitterViewController"],
                         @[@"水纹",@"YFWaterWaveViewController"],
                         @[@"渐变色和贝塞尔曲线",@"YFBezierViewController"],
                         @[@"核心动画",@"YFCoreAnimationViewController"],
                         @[@"抖动密码框",@"YFPasswordShakeViewController"],]];
}


@end
