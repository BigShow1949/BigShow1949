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
    
    self.titles = @[@"动态圆圈",
                    @"渐变色",
                    @"仿支付宝余额跳动",
                    @"加载框",
                    @"手势控制贝塞尔曲线"];
    
    self.classNames = @[@"YFCircleViewController",
                        @"YFGradientViewController",
                        @"YFAliNumberViewController",
                        @"YFCircleLoaderViewController",
                        @"YFBounceViewController"];
}



@end
