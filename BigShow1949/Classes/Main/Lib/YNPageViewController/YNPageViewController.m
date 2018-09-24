//
//  YNPageViewController.m
//  YNPageViewController
//
//  Created by ZYN on 2018/4/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "YNPageViewController.h"
#import "UIView+YNPageExtend.h"
#import "UIScrollView+YNPageExtend.h"
#import "YNPageHeaderScrollView.h"

#define kDEFAULT_INSET_BOTTOM 400

@interface YNPageViewController () <UIScrollViewDelegate, YNPageScrollMenuViewDelegate>

/// 一个HeaderView的背景View
@property (nonatomic, strong) YNPageHeaderScrollView *headerBgView;
/// 页面ScrollView
@property (nonatomic, strong) YNPageScrollView *pageScrollView;
/// 背景ScrollView
@property (nonatomic, strong, readwrite) YNPageScrollView *bgScrollView;
/// 展示控制器的字典
@property (nonatomic, strong) NSMutableDictionary *displayDictM;
/// 原始InsetBottom
@property (nonatomic, strong) NSMutableDictionary *originInsetBottomDictM;
/// 字典控制器的缓存
@property (nonatomic, strong) NSMutableDictionary *cacheDictM;
/// 字典ScrollView的缓存
@property (nonatomic, strong) NSMutableDictionary *scrollViewCacheDictionryM;
/// 当前显示的页面
@property (nonatomic, strong) UIScrollView *currentScrollView;
/// 当前控制器
@property (nonatomic, strong) UIViewController *currentViewController;
/// 上次偏移的位置
@property (nonatomic, assign) CGFloat lastPositionX;
/// TableView距离顶部的偏移量
@property (nonatomic, assign) CGFloat insetTop;
/// 判断headerView是否在列表内
@property (nonatomic, assign) BOOL headerViewInTableView;
/// 菜单栏的初始OriginY
@property (nonatomic, assign) CGFloat scrollMenuViewOriginY;
/// headerView的原始高度 用来处理头部伸缩效果
@property (nonatomic, assign) CGFloat headerViewOriginHeight;
/// 是否是悬浮状态
@property (nonatomic, assign) BOOL supendStatus;
/// 记录bgScrollView Y 偏移量
@property (nonatomic, assign) CGFloat beginBgScrollOffsetY;
/// 记录currentScrollView Y 偏移量
@property (nonatomic, assign) CGFloat beginCurrentScrollOffsetY;

@end

@implementation YNPageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupSubViews];
    [self setSelectedPageIndex:self.pageIndex];
}

#pragma mark - Initialize Method

/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
+ (instancetype)pageViewControllerWithControllers:(NSArray *)controllers
                                           titles:(NSArray *)titles
                                           config:(YNPageConfigration *)config {
    
    return [[self alloc] initPageViewControllerWithControllers:controllers
                                                        titles:titles
                                                        config:config];
}

- (instancetype)initPageViewControllerWithControllers:(NSArray *)controllers
                                               titles:(NSArray *)titles
                                               config:(YNPageConfigration *)config {
    self = [super init];
    self.controllersM = controllers.mutableCopy;
    self.titlesM = titles.mutableCopy;
    self.config = config ?: [YNPageConfigration defaultConfig];
    self.displayDictM = @{}.mutableCopy;
    self.cacheDictM = @{}.mutableCopy;
    self.originInsetBottomDictM = @{}.mutableCopy;
    self.scrollViewCacheDictionryM = @{}.mutableCopy;
    return self;
}

/**
 *  当前PageScrollViewVC作为子控制器
 *
 *  @param parentViewControler 父类控制器
 */
- (void)addSelfToParentViewController:(UIViewController *)parentViewControler {
    [self addChildViewControllerWithChildVC:self parentVC:parentViewControler];
}

/**
 *  从父类控制器里面移除自己（PageScrollViewVC）
 */
- (void)removeSelfViewController {
    [self removeViewControllerWithChildVC:self];
}

#pragma mark - 初始化PageScrollMenu
- (void)initPagescrollMenuViewWithFrame:(CGRect)frame {
    
    YNPageScrollMenuView *scrollMenuView = [YNPageScrollMenuView pagescrollMenuViewWithFrame:frame
                                                                                      titles:self.titlesM
                                                                                configration:self.config
                                                                                    delegate:self currentIndex:self.pageIndex];
    self.scrollMenuView = scrollMenuView;
    
    switch (self.config.pageStyle) {
        case YNPageStyleTop:
        case YNPageStyleSuspensionTop:
        case YNPageStyleSuspensionCenter:
        {
            [self.view addSubview:self.scrollMenuView];
        }
            break;
        case YNPageStyleNavigation:
        {
            UIViewController *vc;
            if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
                vc = self;
            } else {
                vc = self.parentViewController;
            }
            vc.navigationItem.titleView = self.scrollMenuView;
        }
            break;
        case YNPageStyleSuspensionTopPause:
        {
            [self.bgScrollView addSubview:self.scrollMenuView];
        }
            break;
    }

}

#pragma mark - 初始化子控制器
- (void)initViewControllerWithIndex:(NSInteger)index {
    
    self.currentViewController = self.controllersM[index];

    self.pageIndex = index;
    NSString *title = [self titleWithIndex:index];
    if ([self.displayDictM objectForKey:[self getKeyWithTitle:title]]) return;
    
    UIViewController *cacheViewController = [self.cacheDictM objectForKey:[self getKeyWithTitle:title]];
    [self addViewControllerToParent:cacheViewController ?: self.controllersM[index] index:index];

}
/// 添加到父类控制器中
- (void)addViewControllerToParent:(UIViewController *)viewController index:(NSInteger)index {
    
    [self addChildViewController:self.controllersM[index]];
    
    viewController.view.frame = CGRectMake(kYNPAGE_SCREEN_WIDTH * index, 0, self.pageScrollView.yn_width, self.pageScrollView.yn_height);
    
    [self.pageScrollView addSubview:viewController.view];
    
    NSString *title = [self titleWithIndex:index];
    
    [self.displayDictM setObject:viewController forKey:[self getKeyWithTitle:title]];
    
    UIScrollView *scrollView = self.currentScrollView;
    scrollView.frame = viewController.view.bounds;
    
    [viewController didMoveToParentViewController:self];
    
    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
        
        if (![self.cacheDictM objectForKey:[self getKeyWithTitle:title]]) {
            CGFloat bottom = scrollView.contentInset.bottom > 2 * kDEFAULT_INSET_BOTTOM ? 0 : scrollView.contentInset.bottom;
            [self.originInsetBottomDictM setValue:@(bottom) forKey:[self getKeyWithTitle:title]];
            
            /// 设置TableView内容偏移
            scrollView.contentInset = UIEdgeInsetsMake(_insetTop, 0, scrollView.contentInset.bottom + 3 * kDEFAULT_INSET_BOTTOM, 0);
        }
        if ([self isSuspensionBottomStyle]) {
            scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(_insetTop, 0, 0, 0);
        }
        
        if (self.cacheDictM.count == 0) {
            /// 初次添加headerView、scrollMenuView
            self.headerBgView.yn_y = - _insetTop;
            self.scrollMenuView.yn_y = self.headerBgView.yn_bottom;
            [scrollView addSubview:self.headerBgView];
            [scrollView addSubview:self.scrollMenuView];
            /// 设置首次偏移量置顶
            [scrollView setContentOffset:CGPointMake(0, -_insetTop) animated:NO];
            
        } else {
            CGFloat scrollMenuViewY = [self.scrollMenuView.superview convertRect:self.scrollMenuView.frame toView:self.view].origin.y;
            
            if (self.supendStatus) {
                /// 首次已经悬浮 设置初始化 偏移量
                if (![self.cacheDictM objectForKey:[self getKeyWithTitle:title]]) {
                    [scrollView setContentOffset:CGPointMake(0, -self.config.menuHeight - self.config.suspenOffsetY) animated:NO];
                } else {
                    /// 再次悬浮 已经加载过 设置偏移量
                    if (scrollView.contentOffset.y < -self.config.menuHeight - self.config.suspenOffsetY) {
                        [scrollView setContentOffset:CGPointMake(0, -self.config.menuHeight - self.config.suspenOffsetY) animated:NO];
                    }
                }
            } else {
                CGFloat scrollMenuViewDeltaY = _scrollMenuViewOriginY - scrollMenuViewY;
                    scrollMenuViewDeltaY = -_insetTop +  scrollMenuViewDeltaY;
                    /// 求出偏移了多少 未悬浮 (多个ScrollView偏移量联动)
                scrollView.contentOffset = CGPointMake(0, scrollMenuViewDeltaY);
            }
        }
    }
    /// 缓存控制器
    if (![self.cacheDictM objectForKey:[self getKeyWithTitle:title]]) {
        [self.cacheDictM setObject:viewController forKey:[self getKeyWithTitle:title]];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self isSuspensionTopPauseStyle]) {
        if (scrollView == self.bgScrollView) {
            _beginBgScrollOffsetY = scrollView.contentOffset.y;
            _beginCurrentScrollOffsetY = self.currentScrollView.contentOffset.y;
        } else {
            self.currentScrollView.scrollEnabled = NO;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView == self.bgScrollView) return;
    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
        if (!decelerate) {
            [self scrollViewDidScroll:scrollView];
            [self scrollViewDidEndDecelerating:scrollView];
        }
    } else if ([self isSuspensionTopPauseStyle]) {
        self.currentScrollView.scrollEnabled = YES;
    }
}

/// scrollView滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == self.bgScrollView) return;
    if ([self isSuspensionTopPauseStyle]) {
        self.currentScrollView.scrollEnabled = YES;
    }
    [self replaceHeaderViewFromView];
    [self removeViewController];
    [self.scrollMenuView adjustItemPositionWithCurrentIndex:self.pageIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didEndDecelerating:)]) {
        [self.delegate pageViewController:self didEndDecelerating:scrollView];
    }
}

/// scrollView滚动ing
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.bgScrollView) {
        [self calcuSuspendTopPauseWithBgScrollView:scrollView];
        [self invokeDelegateForScrollWithOffsetY:scrollView.contentOffset.y];
        return;
    }
    
    CGFloat currentPostion = scrollView.contentOffset.x;

    CGFloat offsetX = currentPostion / kYNPAGE_SCREEN_WIDTH;

    CGFloat offX = currentPostion > self.lastPositionX ? ceilf(offsetX) : offsetX;

    [self replaceHeaderViewFromTableView];
    
    [self initViewControllerWithIndex:offX];

    CGFloat progress = offsetX - (NSInteger)offsetX;

    self.lastPositionX = currentPostion;
    
    [self.scrollMenuView adjustItemWithProgress:progress lastIndex:floor(offsetX) currentIndex:ceilf(offsetX)];
    
    if (floor(offsetX) == ceilf(offsetX)) {
        [self.scrollMenuView adjustItemAnimate:YES];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didScroll:progress:formIndex:toIndex:)]) {
        [self.delegate pageViewController:self didScroll:scrollView progress:progress formIndex:floor(offsetX) toIndex:ceilf(offsetX)];
    }
}

#pragma mark - yn_pageScrollViewBeginDragginScrollView
- (void)yn_pageScrollViewBeginDragginScrollView:(UIScrollView *)scrollView {
    _beginBgScrollOffsetY = self.bgScrollView.contentOffset.y;
    _beginCurrentScrollOffsetY = scrollView.contentOffset.y;
}

#pragma mark - yn_pageScrollViewDidScrollView
- (void)yn_pageScrollViewDidScrollView:(UIScrollView *)scrollView {
    
    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
        if (!_headerViewInTableView) return;
        
        if (scrollView != self.currentScrollView) return;
        NSString *title = [self titleWithIndex:self.pageIndex];
        CGFloat originInsetBottom = [self.originInsetBottomDictM[[self getKeyWithTitle:title]] floatValue];
        
        if ((scrollView.contentInset.bottom - originInsetBottom) > kDEFAULT_INSET_BOTTOM) {
            scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top, 0, originInsetBottom, 0);
        }
        
        CGFloat offsetY = scrollView.contentOffset.y;
        /// 悬浮临界点
        if (offsetY > - self.scrollMenuView.yn_height - self.config.suspenOffsetY) {
            self.headerBgView.yn_y = -self.headerBgView.yn_height + offsetY + self.config.suspenOffsetY;
            self.scrollMenuView.yn_y = offsetY + self.config.suspenOffsetY;
            self.supendStatus = YES;
        } else {
            /// headerView往下拉置顶
            if (offsetY >= -_insetTop) {
                self.headerBgView.yn_y = -_insetTop;
            } else {
                if ([self isSuspensionBottomStyle]) {
                    self.headerBgView.yn_y = offsetY;
                }
            }
            self.scrollMenuView.yn_y = self.headerBgView.yn_bottom;
            self.supendStatus = NO;
        }
        
        [self adjustSectionHeader:scrollView];
        
        [self invokeDelegateForScrollWithOffsetY:offsetY];
        
        [self headerScaleWithOffsetY:offsetY];
        
    } else if ([self isSuspensionTopPauseStyle]) {
        
        [self calcuSuspendTopPauseWithCurrentScrollView:scrollView];
        
    } else {
         [self invokeDelegateForScrollWithOffsetY:scrollView.contentOffset.y];
    }
}

/// 调整scrollMenuView层级，防止TableView Section Header 挡住
- (void)adjustSectionHeader:(UIScrollView *)scrollview {
    if (scrollview.subviews.lastObject != self.scrollMenuView) {
        [scrollview bringSubviewToFront:self.scrollMenuView];
    }
}

#pragma mark - YNPageScrollMenuViewDelegate
- (void)pagescrollMenuViewItemOnClick:(UIButton *)label index:(NSInteger)index {
    
    [self setSelectedPageIndex:index];
}

- (void)pagescrollMenuViewAddButtonAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didAddButtonAction:)]) {
        [self.delegate pageViewController:self didAddButtonAction:button];
    }
}

#pragma mark - Public Method
- (void)setSelectedPageIndex:(NSInteger)pageIndex {
    
    if (self.cacheDictM.count > 0 && pageIndex == self.pageIndex) return;
    
    if (pageIndex > self.controllersM.count - 1) return;
    
    CGRect frame = CGRectMake(self.pageScrollView.yn_width * pageIndex, 0, self.pageScrollView.yn_width, self.pageScrollView.yn_height);
    if (frame.origin.x == self.pageScrollView.contentOffset.x) {
        [self scrollViewDidScroll:self.pageScrollView];
    } else {
        [self.pageScrollView scrollRectToVisible:frame animated:NO];
    }
    
    [self scrollViewDidEndDecelerating:self.pageScrollView];
    
}

- (void)reloadData {
    
    [self checkParams];
    
    self.pageIndex = self.pageIndex < 0 ? 0 : self.pageIndex;
    self.pageIndex = self.pageIndex >= self.controllersM.count ? self.controllersM.count - 1 : self.pageIndex;
    
    for (UIViewController *vc in self.displayDictM.allValues) {
        [self removeViewControllerWithChildVC:vc];
    }
    [self.displayDictM removeAllObjects];
    
    [self.originInsetBottomDictM removeAllObjects];
    [self.cacheDictM removeAllObjects];
    [self.scrollViewCacheDictionryM removeAllObjects];
    [self.headerBgView removeFromSuperview];
    [self.bgScrollView removeFromSuperview];
    [self.pageScrollView removeFromSuperview];

    [self.scrollMenuView removeFromSuperview];
    
    [self setupSubViews];
    
    [self setSelectedPageIndex:self.pageIndex];
    
}

- (void)updateMenuItemTitle:(NSString *)title index:(NSInteger)index {
    if (index < 0 || index > self.titlesM.count - 1 ) return;
    if (title.length == 0) return;
    NSString *oldTitle = [self titleWithIndex:index];
    UIViewController *cacheVC = self.cacheDictM[[self getKeyWithTitle:oldTitle]];
    if (cacheVC) {
        NSString *newKey = [self getKeyWithTitle:title];
        NSString *oldKey = [self getKeyWithTitle:oldTitle];
        [self.cacheDictM setValue:cacheVC forKey:newKey];
        if (![newKey isEqualToString:oldKey]) {
            [self.cacheDictM setValue:nil forKey:oldKey];
        }
    }
    [self.titlesM replaceObjectAtIndex:index withObject:title];
    [self.scrollMenuView reloadView];
}

- (void)updateMenuItemTitles:(NSArray *)titles {
    if (titles.count != self.titlesM.count) return;
    for (int i = 0; i < titles.count; i++) {
        NSInteger index = i;
        NSString *title = titles[i];
        if (![title isKindOfClass:[NSString class]] || title.length == 0) return;
        NSString *oldTitle = [self titleWithIndex:index];
        UIViewController *cacheVC = self.cacheDictM[[self getKeyWithTitle:oldTitle]];
        if (cacheVC) {
            NSString *newKey = [self getKeyWithTitle:title];
            NSString *oldKey = [self getKeyWithTitle:oldTitle];
            [self.cacheDictM setValue:cacheVC forKey:newKey];
            if (![newKey isEqualToString:oldKey]) {
                [self.cacheDictM setValue:nil forKey:oldKey];
            }
        }
    }
    [self.titlesM replaceObjectsInRange:NSMakeRange(0, titles.count) withObjectsFromArray:titles];
    [self.scrollMenuView reloadView];
}

- (void)insertPageChildControllersWithTitles:(NSArray *)titles
                                 controllers:(NSArray *)controllers
                                       index:(NSInteger)index {
    index = index < 0 ? 0 : index;
    index = index > self.controllersM.count - 1 ? self.controllersM.count - 1 : index;
    NSInteger tarIndex = index;
    BOOL insertSuccess = NO;
    if (titles.count == controllers.count && controllers.count > 0) {
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            if (title.length == 0 || ([self.titlesM containsObject:title] && ![self respondsToCustomCachekey])) {
                continue;
            }
            insertSuccess = YES;
            [self.titlesM insertObject:title atIndex:tarIndex];
            [self.controllersM insertObject:controllers[i] atIndex:tarIndex];
            tarIndex ++;
        }
    }
    if (!insertSuccess) return;
    NSInteger pageIndex = index > self.pageIndex ? self.pageIndex : self.pageIndex + controllers.count;
    
    [self updateViewWithIndex:pageIndex];
    
}

- (void)updateViewWithIndex:(NSInteger)pageIndex {
    
    self.pageScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * self.controllersM.count, self.pageScrollView.yn_height);
    
    UIViewController *vc = self.controllersM[pageIndex];
    
    vc.view.yn_x = kYNPAGE_SCREEN_WIDTH * pageIndex;
    
    [self.scrollMenuView reloadView];
    [self.scrollMenuView selectedItemIndex:pageIndex animated:NO];
    
    CGRect frame = CGRectMake(self.pageScrollView.yn_width * pageIndex, 0, self.pageScrollView.yn_width, self.pageScrollView.yn_height);
    
    [self.pageScrollView scrollRectToVisible:frame animated:NO];
    
    [self scrollViewDidEndDecelerating:self.pageScrollView];
    
    self.pageIndex = pageIndex;
}

- (void)removePageControllerWithTitle:(NSString *)title {
    if ([self respondsToCustomCachekey]) return;
    NSInteger index = -1;
    for (NSInteger i = 0; i < self.titlesM.count; i++) {
        if ([self.titlesM[i] isEqualToString:title]) {
            index = i;
            break;
        }
    }
    if (index == -1) return;
    [self removePageControllerWithIndex:index];
}

- (void)removePageControllerWithIndex:(NSInteger)index {
    
    if (index < 0 || index >= self.titlesM.count || self.titlesM.count == 1) return;
    NSInteger pageIndex = 0;
    if (self.pageIndex >= index) {
        pageIndex = self.pageIndex - 1;
        if (pageIndex < 0) {
            pageIndex = 0;
        }
    }
    /// 等于 0 先选中 + 1个才能移除
    if (pageIndex == 0) {
        [self setSelectedPageIndex:1];
    }
    
    NSString *title = self.titlesM[index];
    [self.titlesM removeObject:self.titlesM[index]];
    [self.controllersM removeObject:self.controllersM[index]];
    
    NSString *key = [self getKeyWithTitle:title];
    
    [self.originInsetBottomDictM removeObjectForKey:key];
    [self.scrollViewCacheDictionryM removeObjectForKey:key];
    [self.cacheDictM removeObjectForKey:key];
    
    [self updateViewWithIndex:pageIndex];
}

- (void)replaceTitlesArrayForSort:(NSArray *)titleArray {
    
    BOOL condition = YES;
    for (NSString *str in titleArray) {
        if (![self.titlesM containsObject:str]) {
            condition = NO;
            break;
        }
    }
    if (!condition || titleArray.count != self.titlesM.count) return;
    
    NSMutableArray *resultArrayM = @[].mutableCopy;
    NSInteger currentPage = self.pageIndex;
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        NSInteger oldIndex = [self.titlesM indexOfObject:title];
        /// 等于上次选择的页面 更换之后的页面
        if (currentPage == oldIndex) {
            self.pageIndex = i;
        }
        [resultArrayM addObject:self.controllersM[oldIndex]];
    }
    
    [self.titlesM removeAllObjects];
    [self.titlesM addObjectsFromArray:titleArray];
    
    [self.controllersM removeAllObjects];
    [self.controllersM addObjectsFromArray:resultArrayM];
    
    [self updateViewWithIndex:self.pageIndex];
    
}

- (void)reloadSuspendHeaderViewFrame {
    if (self.headerView && ([self isSuspensionTopStyle] || [self isSuspensionBottomStyle])) {
        /// 重新初始化headerBgView
        [self setupHeaderBgView];
        for (int i = 0; i < self.titlesM.count; i++) {
            NSString *title = self.titlesM[i];
            if(self.cacheDictM[[self getKeyWithTitle:title]]) {
                UIScrollView *scrollView = [self getScrollViewWithPageIndex:i];
                scrollView.contentInset = UIEdgeInsetsMake(_insetTop, 0, 0, 0);
                if ([self isSuspensionBottomStyle]) {
                    /// 设置偏移量
                    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(_insetTop, 0, 0, 0);
                }
            }
        }
        /// 更新布局
        [self replaceHeaderViewFromTableView];
        [self replaceHeaderViewFromView];
        [self yn_pageScrollViewDidScrollView:self.currentScrollView];
        [self scrollViewDidScroll:self.pageScrollView];
        if (!self.pageScrollView.isDragging) {
            [self scrollViewDidEndDecelerating:self.pageScrollView];
        }
    } else if ([self isSuspensionTopPauseStyle]) {
        /// 重新初始化headerBgView
        [self setupHeaderBgView];
        [self setupPageScrollView];
    }
}

- (void)scrollToTop:(BOOL)animated {
    
    if ([self isSuspensionTopStyle] || [self isSuspensionBottomStyle]) {
        [self.currentScrollView setContentOffset:CGPointMake(0, -self.config.tempTopHeight) animated:animated];
    } else if ([self isSuspensionTopPauseStyle]) {
        [self.currentScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:animated];
    } else {
        [self.currentScrollView setContentOffset:CGPointMake(0, 0) animated:animated];
    }
}

#pragma mark - Private Method

- (void)initData {
    
    [self checkParams];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _headerViewInTableView = YES;

}
/// 初始化子View
- (void)setupSubViews {
    
    [self setupHeaderBgView];
    [self setupPageScrollMenuView];
    [self setupPageScrollView];

}
/// 初始化PageScrollView
- (void)setupPageScrollView {
    
    CGFloat navHeight = self.config.showNavigation ? kYNPAGE_NAVHEIGHT : 0;
    CGFloat tabHeight = self.config.showTabbar ? kYNPAGE_TABBARHEIGHT : 0;
    
    CGFloat contentHeight = kYNPAGE_SCREEN_HEIGHT - navHeight - tabHeight;
    if ([self isSuspensionTopPauseStyle]) {
        self.bgScrollView.frame = CGRectMake(0, 0, kYNPAGE_SCREEN_WIDTH, contentHeight);
        self.bgScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH, contentHeight + self.headerBgView.yn_height - self.config.suspenOffsetY);
        
        self.scrollMenuView.yn_y = self.headerBgView.yn_bottom;
        
        self.pageScrollView.frame = CGRectMake(0, self.scrollMenuView.yn_bottom, kYNPAGE_SCREEN_WIDTH, contentHeight - self.config.menuHeight  - self.config.suspenOffsetY);
        
        self.pageScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * self.controllersM.count, self.pageScrollView.yn_height);
        
        self.config.contentHeight = self.pageScrollView.yn_height;
        
        [self.bgScrollView addSubview:self.pageScrollView];
        if (kLESS_THAN_iOS11) {
            [self.view addSubview:[UIView new]];
        }
        [self.view addSubview:self.bgScrollView];
        
    } else {
        
        self.pageScrollView.frame = CGRectMake(0, [self isTopStyle] ? self.config.menuHeight : 0, kYNPAGE_SCREEN_WIDTH, ([self isTopStyle] ? contentHeight - self.config.menuHeight : contentHeight));
        
        self.pageScrollView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * self.controllersM.count, contentHeight - ([self isTopStyle] ? self.config.menuHeight : 0));
        
        self.config.contentHeight = self.pageScrollView.yn_height - self.config.menuHeight;
        if (kLESS_THAN_iOS11) {
            [self.view addSubview:[UIView new]];            
        }
        [self.view addSubview:self.pageScrollView];
    }
}

/// 初始化ScrollView
- (void)setupPageScrollMenuView {
    [self initPagescrollMenuViewWithFrame:CGRectMake(0, 0, self.config.menuWidth, self.config.menuHeight)];
}

/// 初始化背景headerView
- (void)setupHeaderBgView {
    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle] || [self isSuspensionTopPauseStyle]) {
#if DEBUG
        NSAssert(self.headerView, @"Please set headerView !");
#endif
        self.headerBgView = [[YNPageHeaderScrollView alloc] initWithFrame:self.headerView.bounds];
        self.headerBgView.contentSize = CGSizeMake(kYNPAGE_SCREEN_WIDTH * 2, self.headerView.yn_height);
        [self.headerBgView addSubview:self.headerView];
        self.headerViewOriginHeight = self.headerBgView.yn_height;
        self.headerBgView.scrollEnabled = !self.config.headerViewCouldScrollPage;
        
        if (self.config.headerViewCouldScale && self.scaleBackgroundView) {
            [self.headerBgView insertSubview:self.scaleBackgroundView atIndex:0];
            self.scaleBackgroundView.userInteractionEnabled = NO;
        }
        self.config.tempTopHeight = self.headerBgView.yn_height + self.config.menuHeight;
        
        _insetTop = self.headerBgView.yn_height + self.config.menuHeight;
        
        _scrollMenuViewOriginY = _headerView.yn_height;
        
        if ([self isSuspensionTopPauseStyle]) {
            _insetTop = self.headerBgView.yn_height - self.config.suspenOffsetY;
            [self.bgScrollView addSubview:self.headerBgView];
        }
    }
}

/// 将headerView 从 view 上 放置 tableview 上
- (void)replaceHeaderViewFromView {
    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
        if (!_headerViewInTableView) {
            
            UIScrollView *scrollView = self.currentScrollView;
            
            CGFloat headerViewY = [self.headerBgView.superview convertRect:self.headerBgView.frame toView:scrollView].origin.y;
            CGFloat scrollMenuViewY = [self.scrollMenuView.superview convertRect:self.scrollMenuView.frame toView:scrollView].origin.y;
            
            [self.headerBgView removeFromSuperview];
            [self.scrollMenuView removeFromSuperview];

            self.headerBgView.yn_y = headerViewY;
            self.scrollMenuView.yn_y = scrollMenuViewY;
            
            [scrollView addSubview:self.headerBgView];
            [scrollView addSubview:self.scrollMenuView];
            
            _headerViewInTableView = YES;
        }
    }
}

/// 将headerView 从 tableview 上 放置 view 上
- (void)replaceHeaderViewFromTableView {
    
    if ([self isSuspensionBottomStyle] || [self isSuspensionTopStyle]) {
        if (_headerViewInTableView) {
            
            CGFloat headerViewY = [self.headerBgView.superview convertRect:self.headerBgView.frame toView:self.pageScrollView].origin.y;
            CGFloat scrollMenuViewY = [self.scrollMenuView.superview convertRect:self.scrollMenuView.frame toView:self.pageScrollView].origin.y;
            
            [self.headerBgView removeFromSuperview];
            [self.scrollMenuView removeFromSuperview];
            self.headerBgView.yn_y = headerViewY;
            self.scrollMenuView.yn_y = scrollMenuViewY;
            
            [self.view insertSubview:self.headerBgView aboveSubview:self.pageScrollView];
            [self.view insertSubview:self.scrollMenuView aboveSubview:self.headerBgView];
            
            _headerViewInTableView = NO;
        }
    }
}

/// - 最终效果 current 拖到指定时 bg 才能下拉 ， bg 悬浮时 current 才能上拉
/// 计算悬浮顶部偏移量 - BgScrollView
- (void)calcuSuspendTopPauseWithBgScrollView:(UIScrollView *)scrollView {
    
    if ([self isSuspensionTopPauseStyle] && scrollView == self.bgScrollView) {
        
        CGFloat bg_OffsetY = scrollView.contentOffset.y;
        CGFloat cu_OffsetY = self.currentScrollView.contentOffset.y;
        
        /// 求出拖拽方向
        BOOL dragBottom = _beginBgScrollOffsetY - bg_OffsetY > 0 ? YES : NO;
        /// cu 大于 0 时
        if (dragBottom && cu_OffsetY > 0) {
            /// 设置原来的 出生偏移量
            [scrollView yn_setContentOffsetY:_beginBgScrollOffsetY];
            /// 设置实时滚动的 cu 偏移量
            _beginCurrentScrollOffsetY = cu_OffsetY;
        }
        /// 初始 begin 时超过了 实时 设置
        else if (_beginBgScrollOffsetY == _insetTop && _beginCurrentScrollOffsetY != 0) {
            [scrollView yn_setContentOffsetY:_beginBgScrollOffsetY];
            _beginCurrentScrollOffsetY = cu_OffsetY;
        }
        /// 设置边界
        else if (bg_OffsetY >= _insetTop) {
            [scrollView yn_setContentOffsetY:_insetTop];
            _beginCurrentScrollOffsetY = cu_OffsetY;
        }
        /// 设置边界
        else if (bg_OffsetY <= 0 && cu_OffsetY > 0) {
            [scrollView yn_setContentOffsetY:0];
        }
    }

}

/// 计算悬浮顶部偏移量 - CurrentScrollView
- (void)calcuSuspendTopPauseWithCurrentScrollView:(UIScrollView *)scrollView {

    if ([self isSuspensionTopPauseStyle]) {
        if (!scrollView.isDragging) return;
        CGFloat bg_OffsetY = self.bgScrollView.contentOffset.y;
        CGFloat cu_offsetY = scrollView.contentOffset.y;
        /// 求出拖拽方向
        BOOL dragBottom = _beginCurrentScrollOffsetY - cu_offsetY < 0 ? YES : NO;
        /// cu 是大于 0 的 且 bg 要小于 _insetTop
        if (dragBottom && cu_offsetY > 0 && bg_OffsetY < _insetTop) {
            /// 设置之前的拖动位置
            [scrollView yn_setContentOffsetY:_beginCurrentScrollOffsetY];
            /// 修改 bg 原先偏移量
            _beginBgScrollOffsetY = bg_OffsetY;
        }
        /// cu 拖到 小于 0 就设成0
        else if (cu_offsetY < 0) {
            [scrollView yn_setContentOffsetY:0];
        }
        /// bg 超过了 insetTop 就设置初始化为 _insetTop
        else if (bg_OffsetY >= _insetTop) {
            _beginBgScrollOffsetY = _insetTop;
        }
    }
}

/// 移除缓存控制器
- (void)removeViewController {
    NSString *title = [self titleWithIndex:self.pageIndex];
    NSString *displayKey = [self getKeyWithTitle:title];
    for (NSString *key in self.displayDictM.allKeys) {
        if (![key isEqualToString:displayKey]) {
            [self removeViewControllerWithChildVC:self.displayDictM[key] key:key];
        }
    }
}

/// 从父类控制器移除控制器
- (void)removeViewControllerWithChildVC:(UIViewController *)childVC key:(NSString *)key {
    
    [self removeViewControllerWithChildVC:childVC];
    
    [self.displayDictM removeObjectForKey:key];
    
    if (![self.cacheDictM objectForKey:key]) {
        [self.cacheDictM setObject:childVC forKey:key];
    }
}

/// 添加子控制器
- (void)addChildViewControllerWithChildVC:(UIViewController *)childVC parentVC:(UIViewController *)parentVC {
    [parentVC addChildViewController:childVC];
    [parentVC didMoveToParentViewController:childVC];
    [parentVC.view addSubview:childVC.view];
}

/// 子控制器移除自己
- (void)removeViewControllerWithChildVC:(UIViewController *)childVC {
    [childVC.view removeFromSuperview];
    [childVC willMoveToParentViewController:nil];
    [childVC removeFromParentViewController];
}

/// 检查参数
- (void)checkParams {
#if DEBUG
    NSAssert(self.controllersM.count != 0 || self.controllersM, @"ViewControllers`count is 0 or nil");
    
    NSAssert(self.titlesM.count != 0 || self.titlesM, @"TitleArray`count is 0 or nil,");
    
    NSAssert(self.controllersM.count == self.titlesM.count, @"ViewControllers`count is not equal titleArray!");
#endif
    if (![self respondsToCustomCachekey]) {
        BOOL isHasNotEqualTitle = YES;
        for (int i = 0; i < self.titlesM.count; i++) {
            for (int j = i + 1; j < self.titlesM.count; j++) {
                if (i != j && [self.titlesM[i] isEqualToString:self.titlesM[j]]) {
                    isHasNotEqualTitle = NO;
                    break;
                }
            }
        }
#if DEBUG
        NSAssert(isHasNotEqualTitle, @"TitleArray Not allow equal title.");
#endif
    }
}

- (BOOL)respondsToCustomCachekey {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewController:customCacheKeyForIndex:)]) {
        return YES;
    }
    return NO;
}

#pragma mark - 样式取值
- (BOOL)isTopStyle {
    return self.config.pageStyle == YNPageStyleTop ? YES : NO;
}

- (BOOL)isNavigationStyle {
    return self.config.pageStyle == YNPageStyleNavigation ? YES : NO;
}

- (BOOL)isSuspensionTopStyle {
    return self.config.pageStyle == YNPageStyleSuspensionTop ? YES : NO;
}

- (BOOL)isSuspensionBottomStyle {
    return self.config.pageStyle == YNPageStyleSuspensionCenter ? YES : NO;
}

- (BOOL)isSuspensionTopPauseStyle {
    return self.config.pageStyle == YNPageStyleSuspensionTopPause ? YES : NO;
}

- (NSString *)titleWithIndex:(NSInteger)index {
    return self.titlesM[index];
}

- (NSInteger)getPageIndexWithTitle:(NSString *)title {
    return [self.titlesM indexOfObject:title];
}

- (NSString *)getKeyWithTitle:(NSString *)title {
    if ([self respondsToCustomCachekey]) {
        NSString *ID = [self.dataSource pageViewController:self customCacheKeyForIndex:self.pageIndex];
        return ID;
    }
    return title;
};

#pragma mark - Invoke Delegate Method
/// 回调监听列表滚动代理
- (void)invokeDelegateForScrollWithOffsetY:(CGFloat)offsetY {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:contentOffsetY:progress:)]) {
        switch (self.config.pageStyle) {
            case YNPageStyleSuspensionTop:
            case YNPageStyleSuspensionCenter:
            {
                CGFloat progress = 1 + (offsetY + self.scrollMenuView.yn_height + self.config.suspenOffsetY) / (self.headerBgView.yn_height -self.config.suspenOffsetY);
                progress = progress > 1 ? 1 : progress;
                progress = progress < 0 ? 0 : progress;
                [self.delegate pageViewController:self contentOffsetY:offsetY progress:progress];
            }
                break;
            case YNPageStyleSuspensionTopPause:
            {
                CGFloat progress = offsetY / (self.headerBgView.yn_height - self.config.suspenOffsetY);
                progress = progress > 1 ? 1 : progress;
                progress = progress < 0 ? 0 : progress;
                [self.delegate pageViewController:self contentOffsetY:offsetY progress:progress];
            }
                break;
            default:
            {
                [self.delegate pageViewController:self contentOffsetY:offsetY progress:1];
            }
                break;
        }
    }
}

#pragma mark - Lazy Method

- (YNPageScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[YNPageScrollView alloc] init];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.delegate = self;
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _bgScrollView;
}

- (YNPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[YNPageScrollView alloc] init];
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.scrollEnabled = self.config.pageScrollEnabled;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.bounces = NO;
        _pageScrollView.delegate = self;
        _pageScrollView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _pageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _pageScrollView;
}

/// 当前滚动的ScrollView
- (UIScrollView *)currentScrollView {
    return [self getScrollViewWithPageIndex:self.pageIndex];
}

/// 根据pageIndex 取 数据源 ScrollView
- (UIScrollView *)getScrollViewWithPageIndex:(NSInteger)pageIndex {
    
    NSString *title = [self titleWithIndex:self.pageIndex];
    NSString *key = [self getKeyWithTitle:title];
    UIScrollView *scrollView = nil;
    
    if (![self.scrollViewCacheDictionryM objectForKey:key]) {
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageViewController:pageForIndex:)]) {
            scrollView = [self.dataSource pageViewController:self pageForIndex:pageIndex];
            scrollView.yn_observerDidScrollView = YES;
            __weak typeof(self) weakSelf = self;
            scrollView.yn_pageScrollViewDidScrollView = ^(UIScrollView *scrollView) {
                [weakSelf yn_pageScrollViewDidScrollView:scrollView];
            };
            if (self.config.pageStyle == YNPageStyleSuspensionTopPause) {
                scrollView.yn_pageScrollViewBeginDragginScrollView = ^(UIScrollView *scrollView) {
                    [weakSelf yn_pageScrollViewBeginDragginScrollView:scrollView];
                };
            }
            if (@available(iOS 11.0, *)) {
                if (scrollView) {
                    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                }
            }
        }
    } else {
        return [self.scrollViewCacheDictionryM objectForKey:key];
    }
#if DEBUG
    NSAssert(scrollView != nil, @"请设置pageViewController 的数据源！");
#endif
    [self.scrollViewCacheDictionryM setObject:scrollView forKey:key];
    return scrollView;
}

/// 处理头部伸缩
- (void)headerScaleWithOffsetY:(CGFloat)offsetY {
    
    if (self.config.headerViewCouldScale && self.scaleBackgroundView) {
        CGFloat yOffset  = offsetY + _insetTop;
        CGFloat xOffset = (yOffset) / 2;
        CGRect headerBgViewFrame = self.headerBgView.frame;
        CGRect scaleBgViewFrame = self.scaleBackgroundView.frame;
        if (self.config.headerViewScaleMode == YNPageHeaderViewScaleModeTop) {
            if (yOffset < 0) {
                headerBgViewFrame.origin.y = yOffset - _insetTop;
                headerBgViewFrame.size.height = -yOffset + self.headerViewOriginHeight;
                
                scaleBgViewFrame.size.height = -yOffset + self.headerViewOriginHeight;
                scaleBgViewFrame.origin.x = xOffset;
                scaleBgViewFrame.size.width = kYNPAGE_SCREEN_WIDTH + fabs(xOffset) * 2;
            }
        } else {
            if (yOffset < 0) {
                headerBgViewFrame.origin.y = yOffset - _insetTop;
                headerBgViewFrame.size.height = fabs(yOffset) + self.headerViewOriginHeight;
                
                scaleBgViewFrame.size.height = fabs(yOffset) + self.headerViewOriginHeight;
                scaleBgViewFrame.origin.x = xOffset;
                scaleBgViewFrame.size.width = kYNPAGE_SCREEN_WIDTH + fabs(xOffset) * 2;
            }
        }
        self.headerBgView.frame = headerBgViewFrame;
        self.scaleBackgroundView.frame = scaleBgViewFrame;
    }
}

- (void)dealloc {
#if DEBUG
    NSLog(@"----%@----dealloc", [self class]);
#endif
}

@end
