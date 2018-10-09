//
//  JYSegmentView.h
//  Demo
//
//  Created by weijingyun on 2017/8/29.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSegmentViewProtocol.h"

@interface JYSegmentView : UIView<JYSegmentViewProtocol>

@property (nonatomic, strong) NSArray            *segmentButtons;
@property (nonatomic, copy) void(^clickBlock)(UIView *clickView);
@property (nonatomic, assign) CGFloat             segmentBarHeight;
@property (nonatomic, assign) CGSize              segmentButtonSize;

// 真实际展现同步
@property (nonatomic, assign) NSInteger           currenPage; // 当前页Page

- (void)configureSegmentButtonLayout;


// 只是标记选中状态的，和显示选中状态
@property (nonatomic, assign) NSInteger           currenSelectedPage; // 当前选中的
- (void)setSelectedPage:(NSInteger)selectedPage;


// 查找view从选择的上面  isGesturesSimulate = YES 可以不实现
- (BOOL)findSubSegmentView:(UIView *)view;

@end
