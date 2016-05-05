





//
//  TempViewController.m
//  YXDemo1
//
//  Created by k1er on 16/1/6.
//  Copyright © 2016年 Rudy. All rights reserved.
//

#define COLOR(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define  ScreenSize [UIScreen mainScreen].bounds.size

#import "TempViewController.h"

@interface TempViewController ()
{
    CGFloat screenWidth;
    CGFloat screenHeight;
}
@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initData];
    [self initViews];
}

- (void)initData
{
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)initViews
{
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - 44, screenWidth, 44)];
    [toolView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:toolView];
    UIButton *showBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 12, 120, 20)];
    [showBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [showBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [showBtn setTitle:@"显示窗口列表" forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showViewControllerList) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:showBtn];
}


- (void)showViewControllerList
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showVCList" object:nil];
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com