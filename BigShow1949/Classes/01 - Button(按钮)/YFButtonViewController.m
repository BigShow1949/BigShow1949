//
//  YFButtonViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/16.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFButtonViewController.h"

@interface YFButtonViewController ()

@end

@implementation YFButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 避免按钮多次点击的三种实现方法
    [self setupDataArr:@[@[@"多次点击按钮",@"YFMultipleClicksViewController"],
                         @[@"微信注册按钮",@"YFAnimationCircleButtonVC"],
                         @[@"ape展开按钮",@"YFBubbleMenuButtonViewController"],
                         @[@"各种圆角按钮",@"YFAllRoundButtonVC_UIStoryboard"],]];

}


@end
