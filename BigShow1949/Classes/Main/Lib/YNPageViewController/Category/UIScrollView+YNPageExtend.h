//
//  UIScrollView+YNPageExtend.h
//  YNPageViewController
//
//  Created by ZYN on 2018/5/8.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YNPageScrollViewDidScrollView)(UIScrollView *scrollView);

typedef void(^YNPageScrollViewBeginDragginScrollView)(UIScrollView *scrollView);

@interface UIScrollView (YNPageExtend)

@property (nonatomic, assign) BOOL yn_observerDidScrollView;

@property (nonatomic, copy) YNPageScrollViewDidScrollView yn_pageScrollViewDidScrollView;

@property (nonatomic, copy) YNPageScrollViewBeginDragginScrollView yn_pageScrollViewBeginDragginScrollView;

- (void)yn_setContentOffsetY:(CGFloat)offsetY;

@end
