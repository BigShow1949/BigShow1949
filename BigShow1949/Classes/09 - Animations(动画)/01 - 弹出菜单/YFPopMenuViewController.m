//
//  YFPopMenuViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-4.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFPopMenuViewController.h"

@implementation YFPopMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupDataArr:@[@[@"下拉渐变选框",@"YFContextMenuViewController"],
                         @[@"5个旋转菜单",@"YFAnimationVC02"],
                         @[@"动态弹出框",@"YFAnimationVC03"],
                         @[@"放射性菜单",@"YFAnimationVC04"],
                         @[@"自定义弹出框类型",@"YFAnimationVC05"],
                         @[@"可以拖拽的菜单",@"YFAnimationVC06"],
                         @[@"抖动菜单",@"YFShakeMenuViewController"],]];
}

@end
