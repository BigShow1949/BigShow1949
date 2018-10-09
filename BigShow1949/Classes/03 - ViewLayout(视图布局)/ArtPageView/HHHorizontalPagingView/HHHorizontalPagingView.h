//
//  HHHorizontalPagingView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSegmentViewProtocol.h"

@class HHHorizontalPagingView;

// 使用 allowPullToRefresh 结束刷新需要发出通知
extern NSString* kHHHorizontalScrollViewRefreshStartNotification;
extern NSString* kHHHorizontalScrollViewRefreshEndNotification;
// 监听该通知收回刷新 在切换界面时如果刷新未结束会发出此通知
extern NSString* kHHHorizontalTakeBackRefreshEndNotification;

@protocol HHHorizontalPagingViewDelegate<NSObject>

// 下方左右滑UIScrollView设置
- (NSInteger)numberOfSectionsInPagingView:(HHHorizontalPagingView *)pagingView;
- (UIScrollView *)pagingView:(HHHorizontalPagingView *)pagingView viewAtIndex:(NSInteger)index;

//headerView 设置
- (CGFloat)headerHeightInPagingView:(HHHorizontalPagingView *)pagingView;
- (UIView *)headerViewInPagingView:(HHHorizontalPagingView *)pagingView;

#pragma mark - segmentView 配置
//segmentView 的固定高度 必须实现
- (CGFloat)segmentHeightInPagingView:(HHHorizontalPagingView *)pagingView;
@optional
// 如不实现 segmentViewHeight:pagingView: 则必须实现该代理 采用JYSegmentView
- (NSArray<UIButton*> *)segmentButtonsInPagingView:(HHHorizontalPagingView *)pagingView;
- (UIView<JYSegmentViewProtocol> *)segmentViewHeight:(CGFloat)height pagingView:(HHHorizontalPagingView *)pagingView;


@optional
// 非当前页点击segment
- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelected:(UIView *)item atIndex:(NSInteger)selectedIndex;
// 当前页点击segment
- (void)pagingView:(HHHorizontalPagingView*)pagingView segmentDidSelectedSameItem:(UIView *)item atIndex:(NSInteger)selectedIndex;

// 视图切换完成时调用 从哪里切换到哪里
- (void)pagingView:(HHHorizontalPagingView*)pagingView didSwitchIndex:(NSInteger)aIndex to:(NSInteger)toIndex;

/*
  与 magnifyTopConstraint 属性相对应  下拉时如需要放大，则传入的图片的上边距约束
  考虑到开发中很少使用原生约束，故放开代理方法 用于用户自行根据 偏移处理相应效果
 
  该版本将 magnifyTopConstraint 属性删除
  该代理 和 监听 self.contentOffset 效果是一样的
 */
- (void)pagingView:(HHHorizontalPagingView*)pagingView scrollTopOffset:(CGFloat)offset;


@end


@interface HHHorizontalPagingView : UIView

/**
 *  segment据顶部的距离
 */
@property (nonatomic, assign) CGFloat segmentTopSpace;

/**
 *  是否使用手势模拟 默认 NO
 *  YES ： 会在headerView上添加手势，模拟scorlView 的减速滚动等（效果接近系统）
 *  NO  :  拦截响应view实现，效果最好，但是headerView响应链断裂
 */
@property (nonatomic, assign) BOOL isGesturesSimulate;

/**
 *  允许下拉刷新 默认为NO
 *  pullOffset 下拉的偏移量
 *
 *  在 下拉刷新 开始 和 结束时 需要发出通知
 *  kHHHorizontalScrollViewRefreshStartNotification
 *  kHHHorizontalScrollViewRefreshEndNotification
 *  
    object 传入刷新 的 ScrollView
    [[NSNotificationCenter defaultCenter] postNotificationName:kHHHorizontalScrollViewRefreshEndNotification object:weakSelf.tableView userInfo:nil];
 *
 * - (void)viewWillDisappear:(BOOL)animated 或 - (void)viewWillAppear:(BOOL)animated 也要收起刷新动画
 *
 */
@property (nonatomic, assign) BOOL allowPullToRefresh;
@property (nonatomic, assign, readonly) CGFloat pullOffset;

// 用于整体下拉刷新
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) BOOL isDragging;


/**
 *  缓存视图数 默认是 3
 */
@property (nonatomic, assign) CGFloat maxCacheCout;


/**
 *  切换视图
 */
@property (nonatomic, strong, readonly) UIView<JYSegmentViewProtocol> *segmentView;


/**
 *  实例化横向分页控件
 *  @return  控件对象
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<HHHorizontalPagingViewDelegate>) delegate;

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

/**
 *  获取当前的 UIScrollView
 *
 *  @param index 页号
 */
- (UIScrollView *)scrollViewAtIndex:(NSInteger)index;

// 进行页面刷新
- (void)reload;

@end
