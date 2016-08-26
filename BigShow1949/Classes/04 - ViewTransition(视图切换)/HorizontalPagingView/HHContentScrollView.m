//
//  HHContentScrollView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHContentScrollView.h"

@implementation HHContentScrollView

+ (HHContentScrollView *)contentScrollView {
    HHContentScrollView *scrollView = [[HHContentScrollView alloc] init];
    scrollView.backgroundColor = [UIColor grayColor];
    return scrollView;
}

@end
