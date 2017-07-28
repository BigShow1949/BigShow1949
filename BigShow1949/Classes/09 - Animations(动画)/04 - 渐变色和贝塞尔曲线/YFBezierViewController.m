//
//  YFBezierViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFBezierViewController.h"

@interface YFBezierViewController ()

@end

@implementation YFBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"动态圆圈",@"YFCircleViewController"],
                         @[@"渐变色",@"YFGradientViewController"],
                         @[@"仿支付宝余额跳动",@"YFAliNumberViewController"],
                         @[@"加载框",@"YFCircleLoaderViewController"],
                         @[@"手势控制贝塞尔曲线",@"YFBounceViewController"],]];
}



@end
