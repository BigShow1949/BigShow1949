//
//  JYSegmentViewProtocol.h
//  Demo
//
//  Created by weijingyun on 2017/8/29.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 加在SegmentView上的view 请标记 tag = currentIndex + pagingSubViewTag
static NSInteger pagingSubViewTag                 = 1000;

@protocol JYSegmentViewProtocol <NSObject>

@property (nonatomic, copy) void(^clickBlock)(UIView *clickView);

// 真实际展现同步
@property (nonatomic, assign) NSInteger currenPage; // 当前页Page


// 只是标记选中状态的，和显示选中状态
@property (nonatomic, assign) NSInteger           currenSelectedPage; // 当前选中的
- (void)setSelectedPage:(NSInteger)selectedPage;


@optional
// 查找view从选择的上面  如果isGesturesSimulate = YES 可以不实现
- (BOOL)findSubSegmentView:(UIView *)view;

@end
