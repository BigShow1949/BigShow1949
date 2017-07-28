//
//  YFLittleProjectViewController.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFLittleProjectViewController.h"

#import "YFRotateButtonViewController.h"
#import "YFLittleProjectVC02.h"
#import "YFLittleProjectVC03.h"


@implementation YFLittleProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"旋转动画",@"YFRotateButtonViewController"],
                         @[@"表情键盘",@"YFLittleProjectVC02"],
                         @[@"游戏2048",@"YFLittleProjectVC03"],
                         @[@"拼图",@"YFJigsawViewController"],]];
    
}

@end
