//
//  UIViewController+YNPageExtend.m
//  YNPageViewController
//
//  Created by ZYN on 2018/5/25.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "UIViewController+YNPageExtend.h"

@implementation UIViewController (YNPageExtend)

- (YNPageViewController *)yn_pageViewController {
    return (YNPageViewController *)self.parentViewController;
}

- (YNPageConfigration *)config {
    return self.yn_pageViewController.config;
}

- (YNPageScrollView *)bgScrollView {
    return self.yn_pageViewController.bgScrollView;
}

- (YNPageScrollMenuView *)scrollMenuView {
    return self.yn_pageViewController.scrollMenuView;
}

- (NSMutableArray<__kindof UIViewController *> *)controllersM {
    return self.yn_pageViewController.controllersM;
}

- (NSMutableArray<NSString *> *)titlesM {
    return self.yn_pageViewController.titlesM;
}

@end
