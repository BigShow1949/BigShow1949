//
//  YNPageViewController.h
//  YNPageViewController
//
//  Created by ZYN on 2018/4/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNPageConfigration.h"
#import "YNPageScrollMenuView.h"
#import "YNPageScrollView.h"


@class YNPageViewController;

@protocol YNPageViewControllerDelegate <NSObject>
@optional

/**
 滚动列表内容时回调
 
 @param pageViewController PageVC
 @param contentOffsetY 内容偏移量
 @param progress 进度
 */
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffsetY
                  progress:(CGFloat)progress;

/**
 UIScrollView拖动停止时回调, 可用来自定义 ScrollMenuView
 
 @param pageViewController PageVC
 @param scrollView UIScrollView
 */
- (void)pageViewController:(YNPageViewController *)pageViewController
        didEndDecelerating:(UIScrollView *)scrollView;

/**
 UIScrollView滚动时回调, 可用来自定义 ScrollMenuView
 
 @param pageViewController PageVC
 @param scrollView UIScrollView
 @param progress 进度
 @param fromIndex 从哪个页面
 @param toIndex 到哪个页面
 */
- (void)pageViewController:(YNPageViewController *)pageViewController
                 didScroll:(UIScrollView *)scrollView
                  progress:(CGFloat)progress
                 formIndex:(NSInteger)fromIndex
                   toIndex:(NSInteger)toIndex;

/**
 点击UIScrollMenuView AddAction
 
 @param pageViewController PageVC
 @param button Add按钮
 */
- (void)pageViewController:(YNPageViewController *)pageViewController
        didAddButtonAction:(UIButton *)button;


@end

@protocol YNPageViewControllerDataSource <NSObject>
@required

/**
 根据 index 取 数据源 ScrollView
 
 @param pageViewController PageVC
 @param index pageIndex
 @return 数据源
 */
- (__kindof UIScrollView *)pageViewController:(YNPageViewController *)pageViewController
                                 pageForIndex:(NSInteger )index;


@optional
/**
 自定义缓存Key 如果不实现，则不允许相同的菜单栏title
 如果对页面进行了添加、删除、调整顺序、请一起调整传递进来的数据源，防止缓存Key取错
 @param pageViewController pageVC
 @param index pageIndex
 @return 唯一标识 (一般是后台ID)
 */
- (NSString *)pageViewController:(YNPageViewController *)pageViewController
          customCacheKeyForIndex:(NSInteger )index;

@end

@interface YNPageViewController : UIViewController
/// 配置信息
@property (nonatomic, strong) YNPageConfigration *config;
/// 控制器数组
@property (nonatomic, strong) NSMutableArray<__kindof UIViewController *> *controllersM;
/// 标题数组 默认 缓存 key 为 title 可通过数据源代理 进行替换
@property (nonatomic, strong) NSMutableArray<NSString *> *titlesM;
/// 菜单栏
@property (nonatomic, strong) YNPageScrollMenuView *scrollMenuView;
/// 背景ScrollView
@property (nonatomic, strong, readonly) YNPageScrollView *bgScrollView;
/// 头部headerView
@property (nonatomic, strong) UIView *headerView;
/// 数据源
@property (nonatomic, weak) id<YNPageViewControllerDataSource> dataSource;
/// 代理
@property (nonatomic, weak) id<YNPageViewControllerDelegate> delegate;
/// 当前页面index
@property (nonatomic, assign) NSInteger pageIndex;
/// 头部伸缩背景View
@property (nonatomic, strong) UIView *scaleBackgroundView;

#pragma mark - initialize

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
+ (instancetype)pageViewControllerWithControllers:(NSArray *)controllers
                                           titles:(NSArray *)titles
                                           config:(YNPageConfigration *)config;
/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
- (instancetype)initPageViewControllerWithControllers:(NSArray *)controllers
                                               titles:(NSArray *)titles
                                               config:(YNPageConfigration *)config;

/**
 *  当前PageScrollViewVC作为子控制器
 *  @param parentViewControler 父类控制器
 */
- (void)addSelfToParentViewController:(UIViewController *)parentViewControler;

/**
 *  从父类控制器里面移除自己（PageScrollViewVC）
 */
- (void)removeSelfViewController;

/**
 刷新数据页面、所有View、菜单栏、headerView - 默认移除缓存控制器
 刷新菜单栏配置 标题数组
 e.g: vc.config = ...
 vc.titlesM = [self getArrayTitles].mutableCopy;
 
 如果需要重新走控制器的ViewDidLoad方法则需要重新赋值 controllers
 e.g:
 vc.controllersM = [self getArrayVCs].mutableCopy;
 */
- (void)reloadData;

/**
 选中页码
 @param pageIndex 页面下标
 */
- (void)setSelectedPageIndex:(NSInteger)pageIndex;

/**
 更新菜单栏标题
 @param title 标题
 @param index index
 */
- (void)updateMenuItemTitle:(NSString *)title index:(NSInteger)index;

/**
 更新全部菜单栏标题
 @param titles 标题数组
 */
- (void)updateMenuItemTitles:(NSArray *)titles;

/**
 批量插入控制器
 @param titles 标题数组
 @param controllers 控制器数组
 @param index 插入的下标
 */
- (void)insertPageChildControllersWithTitles:(NSArray *)titles
                                 controllers:(NSArray *)controllers
                                       index:(NSInteger)index;
/**
 根据标题移除控制器
 @param title 标题
 */
- (void)removePageControllerWithTitle:(NSString *)title;

/**
 根据下标移除控制器
 @param index 下标
 */
- (void)removePageControllerWithIndex:(NSInteger)index;

/**
 *  调整标题数组顺序 - 控制器也会跟着调整
 *
 *  @param titleArray 标题数组 需要与原来的titles数组相同
 */
- (void)replaceTitlesArrayForSort:(NSArray *)titleArray;

/**
 * 刷新悬浮HeaderViewFrame
 * YNPageStyleSuspensionTop 样式 1.需要对刷新控件进行特殊处理 2.需要在下拉刷新完成时调用该方法
 * YNPageStyleSuspensionCenter 样式 1.需要在下拉刷新完成时调用该方法
 */
- (void)reloadSuspendHeaderViewFrame;

/**
 滚动到顶部(置顶)
 @param animated 是否动画
 */
- (void)scrollToTop:(BOOL)animated;



@end
