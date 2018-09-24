//
//  UIViewController+YNPageExtend.h
//  YNPageViewController
//
//  Created by ZYN on 2018/5/25.
//  Copyright © 2018年 yongneng. All rights reserved.
//  提供在 子控制器 提供快速取值

#import <UIKit/UIKit.h>
#import "YNPageViewController.h"

@interface UIViewController (YNPageExtend)

- (YNPageViewController *)yn_pageViewController;

- (YNPageConfigration *)config;

- (YNPageScrollView *)bgScrollView;

- (YNPageScrollMenuView *)scrollMenuView;

- (NSMutableArray<__kindof UIViewController *> *)controllersM;

- (NSMutableArray<NSString *> *)titlesM;

@end
