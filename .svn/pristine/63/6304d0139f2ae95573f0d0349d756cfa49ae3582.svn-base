//
//  HHHorizontalPagingView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HHSegmentView;

@interface HHHorizontalPagingView : UIView

/**
 *  segment据顶部的距离
 */
@property (nonatomic, assign) CGFloat segmentTopSpace;

/**
 *  自定义segmentButton的size
 */
@property (nonatomic, assign) CGSize segmentButtonSize;

/**
 *  下拉时如需要放大，则传入的图片的上边距约束，默认为不放大
 */
@property (nonatomic, strong) NSLayoutConstraint *magnifyTopConstraint;

/**
 *  切换视图
 */
@property (nonatomic, strong, readonly) UIView *segmentView;

/**
 *  视图切换的回调block
 */
@property (nonatomic, copy) void (^pagingViewSwitchBlock)(NSInteger switchIndex);

/**
 *  视图点击的回调block
 */
@property (nonatomic, copy) void (^clickEventViewsBlock)(UIView *eventView);

/**
 *  实例化横向分页控件
 *
 *  @param headerView     tableHeaderView
 *  @param headerHeight   tableHeaderView高度
 *  @param segmentButtons 切换按钮的数组
 *  @param segmentHeight  切换视图高度
 *  @param contentViews   内容视图的数组
 *
 *  @return  控件对象
 */
+ (HHHorizontalPagingView *)pagingViewWithHeaderView:(UIView *)headerView
                                        headerHeight:(CGFloat)headerHeight
                                      segmentButtons:(NSArray *)segmentButtons
                                       segmentHeight:(CGFloat)segmentHeight
                                        contentViews:(NSArray *)contentViews;

/**
 *  手动控制滚动到某个视图
 *
 *  @param pageIndex 页号
 */
- (void)scrollToIndex:(NSInteger)pageIndex;

/**
 *  左右滑动
 *
 *  @param enable 是否允许滚动
 */
- (void)scrollEnable:(BOOL)enable;

@end
