//
//  UIScrollView+Dragging.h
//  Demo
//
//  Created by weijingyun on 16/12/3.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Dragging)

@property (nonatomic, assign) BOOL hhh_isRefresh;  // 刷新中
@property (nonatomic, assign) BOOL hhh_startRefresh; // 开始刷新 保证下拉时不触发headView
- (void)setDragging:(BOOL)dragging;

@end
