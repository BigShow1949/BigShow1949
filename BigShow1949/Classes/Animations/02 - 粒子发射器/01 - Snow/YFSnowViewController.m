//
//  YFSnowViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-4.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFSnowViewController.h"
#import "YFAnimationManager.h"

@interface YFSnowViewController ()

@end

@implementation YFSnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"飘浮的雪花";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [[YFAnimationManager shareInstancetype] showAnimationInView:self.view withAnimationStyle:YFAnimationStyleOfSnow]; // 雨水有问题
}



@end
