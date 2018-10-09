//
//  HHHorizontalPagingView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHHorizontalPagingView.h"
#import "DynamicItem.h"
#import <objc/runtime.h>
#import "UIView+WhenTappedBlocks.h"
#import "UIScrollView+Dragging.h"

#import "JYSegmentView.h"

NSString* kHHHorizontalScrollViewRefreshStartNotification = @"kHHHorizontalScrollViewRefreshStartNotification";
NSString* kHHHorizontalScrollViewRefreshEndNotification = @"kHHHorizontalScrollViewRefreshEndNotification";
NSString* kHHHorizontalTakeBackRefreshEndNotification = @"kHHHorizontalTakeBackRefreshEndNotification";

@interface HHHorizontalPagingView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView             *headerView;
@property (nonatomic, strong) NSMutableArray<UIScrollView *>*contentViewArray;

@property (nonatomic, strong) UIView<JYSegmentViewProtocol> *segmentView;

@property (nonatomic, strong) UICollectionView   *horizontalCollectionView;

@property (nonatomic, weak)   UIScrollView       *currentScrollView;
@property (nonatomic, strong) NSLayoutConstraint *headerOriginYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *headerSizeHeightConstraint;
@property (nonatomic, assign) CGFloat            headerViewHeight;
@property (nonatomic, assign) CGFloat            segmentBarHeight;
@property (nonatomic, assign) BOOL               isSwitching;

@property (nonatomic, strong) UIView             *currentTouchView;
@property (nonatomic, assign) CGPoint            currentTouchViewPoint;
@property (nonatomic, strong) UIView             *currentTouchSubSegment;
@property (nonatomic, assign) CGFloat            pullOffset;
@property (nonatomic, assign) BOOL               isScroll;// 是否左右滚动

/**
 *  用于模拟scrollView滚动
 */
@property (nonatomic, strong) UIDynamicAnimator  *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *inertialBehavior;

/**
 *  代理
 */
@property (nonatomic, weak) id<HHHorizontalPagingViewDelegate> delegate;

@end

@implementation HHHorizontalPagingView

static void *HHHorizontalPagingViewScrollContext = &HHHorizontalPagingViewScrollContext;
static void *HHHorizontalPagingViewInsetContext  = &HHHorizontalPagingViewInsetContext;
static void *HHHorizontalPagingViewPanContext    = &HHHorizontalPagingViewPanContext;
static NSString *pagingCellIdentifier            = @"PagingCellIdentifier";
static NSInteger pagingScrollViewTag             = 2000;

#pragma mark - HHHorizontalPagingView
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<HHHorizontalPagingViewDelegate>) delegate{
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        // UICollectionView
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing          = 0.0;
        layout.minimumInteritemSpacing     = 0.0;
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        self.horizontalCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        
        // 应当为每一个ScrollView 注册一个唯一的Cell
        NSInteger section = [self.delegate numberOfSectionsInPagingView:self];
        [self registCellForm:0 to:section];
        
        self.horizontalCollectionView.backgroundColor                = [UIColor clearColor];
        self.horizontalCollectionView.dataSource                     = self;
        self.horizontalCollectionView.delegate                       = self;
        self.horizontalCollectionView.pagingEnabled                  = YES;
        self.horizontalCollectionView.showsHorizontalScrollIndicator = NO;
        self.horizontalCollectionView.scrollsToTop                   = NO;
        
        // iOS10 上将该属性设置为 NO，就会预取cell了
        if([self.horizontalCollectionView respondsToSelector:@selector(setPrefetchingEnabled:)]) {
            self.horizontalCollectionView.prefetchingEnabled = NO;
        }
        
        // iOS11 适配
        if (@available(iOS 11.0, *)) {
            [self.horizontalCollectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        
        UICollectionViewFlowLayout *tempLayout = (id)self.horizontalCollectionView.collectionViewLayout;
        tempLayout.itemSize = self.horizontalCollectionView.frame.size;
        [self addSubview:self.horizontalCollectionView];
        [self configureHeaderView];
        [self configureSegmentView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(releaseCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshStart:) name:kHHHorizontalScrollViewRefreshStartNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEnd:) name:kHHHorizontalScrollViewRefreshEndNotification object:nil];
        
    }
    return self;
}


- (void)reload{
  
    self.headerView                  = [self.delegate headerViewInPagingView:self];
    self.headerViewHeight            = [self.delegate headerHeightInPagingView:self];
    self.segmentBarHeight            = [self.delegate segmentHeightInPagingView:self];
    [self configureHeaderView];
    [self configureSegmentView];
    
    // 防止该section 是计算得出会改变导致后面崩溃
    NSInteger section = [self.delegate numberOfSectionsInPagingView:self];
    [self registCellForm:0 to:section];
    [self.horizontalCollectionView reloadData];
}

// 注册cell
- (void)registCellForm:(NSInteger)form to:(NSInteger)to{
  
  for (NSInteger i = form; i < to; i ++) {
    [self.horizontalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[self cellReuseIdentifierForIndex:i]];
  }
}

- (NSString *)cellReuseIdentifierForIndex:(NSInteger)aIndex{
  return [NSString stringWithFormat:@"%@_%tu",pagingCellIdentifier,aIndex];
}

- (CGFloat)pullOffset{
    if (_pullOffset == 0) {
        _pullOffset = [self.delegate headerHeightInPagingView:self] + [self.delegate segmentHeightInPagingView:self];
    }
    return _pullOffset;
}

- (void)scrollToIndex:(NSInteger)pageIndex {
    UIView *clickView = [self.segmentView viewWithTag:pagingSubViewTag + pageIndex];
    [self segmentViewEvent:clickView];
}

- (void)scrollEnable:(BOOL)enable {
    if(enable) {
        self.segmentView.userInteractionEnabled     = YES;
        self.horizontalCollectionView.scrollEnabled = YES;
    }else {
        self.segmentView.userInteractionEnabled     = NO;
        self.horizontalCollectionView.scrollEnabled = NO;
    }
}

- (void)configureHeaderView {
    [self.headerView removeFromSuperview];
    if(self.headerView) {
        self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.headerView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        self.headerOriginYConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        [self addConstraint:self.headerOriginYConstraint];
        
        self.headerSizeHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.headerViewHeight];
        [self.headerView addConstraint:self.headerSizeHeightConstraint];
        [self addGestureRecognizerAtHeaderView];
    }
}

- (void)configureSegmentView {
    [self.segmentView removeFromSuperview];
    self.segmentView = nil;
    if(self.segmentView) {
        self.segmentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.segmentView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView ? : self attribute:self.headerView ? NSLayoutAttributeBottom : NSLayoutAttributeTop multiplier:1 constant:0]];
        [self.segmentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.segmentBarHeight]];
    }
}

- (UIScrollView *)scrollViewAtIndex:(NSInteger)index{
    
    __block UIScrollView *scrollView = nil;
    [self.contentViewArray enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == pagingScrollViewTag + index) {
            scrollView = obj;
            *stop = YES;
        }
    }];

    if (scrollView == nil) {
        scrollView = [self.delegate pagingView:self viewAtIndex:index];
        if ([scrollView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)scrollView;
            tableView.sectionHeaderHeight = 0.;
            tableView.sectionFooterHeight = 0.;
            tableView.estimatedRowHeight = 0.;
            tableView.estimatedSectionFooterHeight = 0.;
            tableView.estimatedSectionHeaderHeight = 0.;
        }
       
        if (@available(iOS 11.0, *)) {
            [scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        [self configureContentView:scrollView];
        scrollView.tag = pagingScrollViewTag + index;
        [self.contentViewArray addObject:scrollView];
    }
    return scrollView;
}

- (void)configureContentView:(UIScrollView *)scrollView{
    [scrollView  setContentInset:UIEdgeInsetsMake(self.headerViewHeight+self.segmentBarHeight, 0., scrollView.contentInset.bottom, 0.)];
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentOffset = CGPointMake(0., -self.headerViewHeight-self.segmentBarHeight);
    [scrollView.panGestureRecognizer addObserver:self forKeyPath:NSStringFromSelector(@selector(state)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&HHHorizontalPagingViewPanContext];
    [scrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&HHHorizontalPagingViewScrollContext];
    [scrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentInset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&HHHorizontalPagingViewInsetContext];
    if (scrollView == nil) {
        self.currentScrollView = scrollView;
    }
}

- (UIView<JYSegmentViewProtocol> *)segmentView {
    if(!_segmentView) {
        
        CGFloat height = [self.delegate segmentHeightInPagingView:self];
        if ([self.delegate respondsToSelector:@selector(segmentViewHeight:pagingView:)]) {
            _segmentView = [self.delegate segmentViewHeight:height pagingView:self];
        }else {
            _segmentView = [[JYSegmentView alloc] init];
            JYSegmentView *view = (JYSegmentView *)_segmentView;
            view.segmentButtons = [self.delegate segmentButtonsInPagingView:self];
            view.segmentBarHeight = height;
            [view configureSegmentButtonLayout];
        }
        __weak typeof(self)weakSelf = self;
        _segmentView.clickBlock = ^(UIView *view) {
            [weakSelf segmentViewEvent:view];
        };
    }
    return _segmentView;
}

- (void)segmentViewEvent:(UIView *)segmentView {
    
    NSInteger clickIndex = segmentView.tag - pagingSubViewTag;
    if (clickIndex >= [self.delegate numberOfSectionsInPagingView:self]) {
        if ([self.delegate respondsToSelector:@selector(pagingView:segmentDidSelected:atIndex:)]) {
            [self.delegate pagingView:self segmentDidSelected:segmentView atIndex:clickIndex];
        }
        return;
    }
    
    // 在当前页被点击
    if (clickIndex == self.segmentView.currenPage) {
        if ([self.delegate respondsToSelector:@selector(pagingView:segmentDidSelectedSameItem:atIndex:)]) {
            [self.delegate pagingView:self segmentDidSelectedSameItem:segmentView atIndex:clickIndex];
        }
        return;
    }
    
    // 非当前页被点击
    [self.horizontalCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:clickIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    if(self.currentScrollView.contentOffset.y<-(self.headerViewHeight+self.segmentBarHeight)) {
        [self.currentScrollView setContentOffset:CGPointMake(self.currentScrollView.contentOffset.x, -(self.headerViewHeight+self.segmentBarHeight)) animated:NO];
    }else {
        [self.currentScrollView setContentOffset:self.currentScrollView.contentOffset animated:NO];
    }
    
    if ([self.delegate respondsToSelector:@selector(pagingView:segmentDidSelected:atIndex:)]) {
        [self.delegate pagingView:self segmentDidSelected:segmentView atIndex:clickIndex];
    }
    
    // 视图切换时执行代码
    [self didSwitchIndex:self.segmentView.currenPage to:clickIndex];
}

- (void)adjustOffsetContentView:(UIScrollView *)scrollView {
    self.isSwitching = YES;
    CGFloat headerViewDisplayHeight = self.headerViewHeight + self.headerView.frame.origin.y;
    [scrollView layoutIfNeeded];
    
    if (headerViewDisplayHeight != self.segmentTopSpace) {// 还原位置
        [scrollView setContentOffset:CGPointMake(0, -headerViewDisplayHeight - self.segmentBarHeight)];
    }else if(scrollView.contentOffset.y < -self.segmentBarHeight) {
        [scrollView setContentOffset:CGPointMake(0, -headerViewDisplayHeight-self.segmentBarHeight)];
    }else {
        // self.segmentTopSpace
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y-headerViewDisplayHeight + self.segmentTopSpace)];
    }
    
    if ([scrollView.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [scrollView.delegate scrollViewDidEndDragging:scrollView willDecelerate:NO];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0)), dispatch_get_main_queue(), ^{
        self.isSwitching = NO;
    });
}

#pragma mark - 对headerView触发滚动的两种处理
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    if(point.x < 10) {
        return NO;
    }
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
//    BUG -[__NSCFType isDescendantOfView:]: unrecognized selector sent to instance 0x9dd30e0
    if (![view isKindOfClass:[UIView class]]) {
        return nil;
    }
    
    if (self.isGesturesSimulate) {
        return view;
    }
    
    // 如果处于刷新中，作用在headerView上的手势不响应在currentScrollView上
    if (self.currentScrollView.hhh_isRefresh) {
        return view;
    }
    
    if ([view isDescendantOfView:self.headerView] || [view isDescendantOfView:self.segmentView]) {
        self.horizontalCollectionView.scrollEnabled = NO;
        
        self.currentTouchView = nil;
        self.currentTouchSubSegment = [self.segmentView findSubSegmentView:view] ? view : nil;
        if(!self.currentTouchSubSegment) {
            self.currentTouchView = view;
            self.currentTouchViewPoint = [self convertPoint:point toView:self.currentTouchView];
        }else {
            return view;
        }
        
        return self.currentScrollView;
    }
    return view;
}

- (void)addGestureRecognizerAtHeaderView{
    
    if (self.isGesturesSimulate == NO) {
        return;
    }
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.headerView addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self.headerView];
        if (fabs(point.y)  <=  fabs(point.x)) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)pan:(UIPanGestureRecognizer*)pan{
   
    // 如果处于刷新中，作用在headerView上的手势不响应
    if (self.currentScrollView.hhh_isRefresh) {
        return;
    }
    
    // 手势模拟 兼容整体下来刷新
    self.isDragging = !(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed);
    [self.currentScrollView setDragging:self.isDragging];
    
    // 偏移计算
    CGPoint point = [pan translationInView:self.headerView];
    CGPoint contentOffset = self.currentScrollView.contentOffset;
    CGFloat border = - self.headerViewHeight - [self.delegate segmentHeightInPagingView:self];
    NSLog(@"border = %f", border);
    CGFloat offsety = contentOffset.y - point.y * (1/contentOffset.y * border * 0.8);
    self.currentScrollView.contentOffset = CGPointMake(contentOffset.x, offsety);
    NSLog(@"contentOffset.y = %f", contentOffset.y);
    
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateFailed) {
        if (contentOffset.y <= border) {
            // 如果处于刷新
            if (self.currentScrollView.hhh_isRefresh) {
                return;
            }
            // 模拟弹回效果
            [UIView animateWithDuration:0.35 animations:^{
                self.currentScrollView.contentOffset = CGPointMake(contentOffset.x, border);
                [self layoutIfNeeded];
            }];

        }else{
            // 模拟减速滚动效果
            CGFloat velocity = [pan velocityInView:self.headerView].y;
            [self deceleratingAnimator:velocity];
        }
    }
    // 清零防止偏移累计
    [pan setTranslation:CGPointZero inView:self.headerView];
    
}

- (void)deceleratingAnimator:(CGFloat)velocity{
    
    if (self.inertialBehavior != nil) {
        [self.animator removeBehavior:self.inertialBehavior];
    }
    DynamicItem *item = [[DynamicItem alloc] init];
    item.center = CGPointMake(0, 0);
    // velocity是在手势结束的时候获取的竖直方向的手势速度
    UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ item ]];
    [inertialBehavior addLinearVelocity:CGPointMake(0, velocity * 0.025) forItem:item];
    // 通过尝试取2.0比较像系统的效果
    inertialBehavior.resistance = 2;
    
    __weak typeof(self)weakSelf = self;
    CGFloat maxOffset = self.currentScrollView.contentSize.height - self.currentScrollView.bounds.size.height;
    inertialBehavior.action = ^{
        
        CGPoint contentOffset = weakSelf.currentScrollView.contentOffset;
        CGFloat speed = [weakSelf.inertialBehavior linearVelocityForItem:item].y;
        CGFloat offset = contentOffset.y -  speed;
        
        if (speed >= -0.2) {
            
            [weakSelf.animator removeBehavior:weakSelf.inertialBehavior];
            weakSelf.inertialBehavior = nil;
        }else if (offset >= maxOffset){
            
            [weakSelf.animator removeBehavior:weakSelf.inertialBehavior];
            weakSelf.inertialBehavior = nil;
            offset = maxOffset;
            // 模拟减速滚动到scrollView最底部时，先拉一点再弹回的效果
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.currentScrollView.contentOffset = CGPointMake(contentOffset.x, offset - speed);
                [weakSelf layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.currentScrollView.contentOffset = CGPointMake(contentOffset.x, offset);
                    [weakSelf layoutIfNeeded];
                }];
            }];
        }else{
            
            weakSelf.currentScrollView.contentOffset = CGPointMake(contentOffset.x, offset);
        }
    };
    self.inertialBehavior = inertialBehavior;
    [self.animator addBehavior:inertialBehavior];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
    return [self.delegate numberOfSectionsInPagingView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.isSwitching = YES;
    NSString* key = [self cellReuseIdentifierForIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:key forIndexPath:indexPath];
    UIScrollView *v = [self scrollViewAtIndex:indexPath.row];
  
  // 只有在cell未添加scrollView时才添加，让以下代码只在需要时执行
  if (cell.contentView.tag != v.tag) {
    
    cell.backgroundColor = [UIColor clearColor];
    for(UIView *v in cell.contentView.subviews) {
      [v removeFromSuperview];
    }
    cell.tag = v.tag;
    UIViewController *vc = [self viewControllerForView:v];
    // 如果为空表示 v还没有响应者，在部分机型上出现该问题，情况不明先这么看看
      [cell.contentView addSubview:vc.view];
      cell.tag = v.tag;
      
      vc.view.translatesAutoresizingMaskIntoConstraints = NO;
      [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
      [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
      [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
      [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:vc.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

     [cell layoutIfNeeded];
  }
  
  
    self.currentScrollView = v;
    [self adjustOffsetContentView:v];
    return cell;
    
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(__unused id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if(context == &HHHorizontalPagingViewPanContext) {
        self.isDragging = YES;
        self.horizontalCollectionView.scrollEnabled = YES;
        UIGestureRecognizerState state = [change[NSKeyValueChangeNewKey] integerValue];
        //failed说明是点击事件
        if(state == UIGestureRecognizerStateFailed) {
            if(self.currentTouchSubSegment) {
                [self segmentViewEvent:self.currentTouchSubSegment];
            }else if(self.currentTouchView) {
                [self.currentTouchView viewWasTappedPoint:self.currentTouchViewPoint];
            }
            self.currentTouchView = nil;
            self.currentTouchSubSegment = nil;
        }else if (state == UIGestureRecognizerStateCancelled || state == UIGestureRecognizerStateEnded) {
            self.isDragging = NO;
        }
        
    }else if (context == &HHHorizontalPagingViewScrollContext) {
        
        self.currentTouchView = nil;
        self.currentTouchSubSegment = nil;
        if (self.isSwitching) {
            return;
        }
        
        // 触发如果不是当前 ScrollView 不予响应
        if (object != self.currentScrollView) {
            return;
        }
        
        CGFloat oldOffsetY          = [change[NSKeyValueChangeOldKey] CGPointValue].y;
        CGFloat newOffsetY          = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        CGFloat deltaY              = newOffsetY - oldOffsetY;
        NSLog(@"deltaY ====== %f", deltaY);
        CGFloat headerViewHeight    = self.headerViewHeight;
        CGFloat headerDisplayHeight = self.headerViewHeight+self.headerOriginYConstraint.constant;
        
        CGFloat py = 0;
        if(deltaY >= 0) {    //向上滚动
            
            if(headerDisplayHeight - deltaY <= self.segmentTopSpace) {
                py = -headerViewHeight+self.segmentTopSpace;
            }else {
                py = self.headerOriginYConstraint.constant - deltaY;
            }
            if(headerDisplayHeight <= self.segmentTopSpace) {
                py = -headerViewHeight+self.segmentTopSpace;
            }

            if (!self.allowPullToRefresh) {
                self.headerOriginYConstraint.constant = py;

            }else if (py < 0 && !self.currentScrollView.hhh_isRefresh && !self.currentScrollView.hhh_startRefresh) {
                self.headerOriginYConstraint.constant = py;

            }else{

                if (self.currentScrollView.contentOffset.y >= -headerViewHeight -  self.segmentBarHeight) {
                    self.currentScrollView.hhh_startRefresh = NO;
                }
                self.headerOriginYConstraint.constant = 0;
            }
            
            
        }else {            //向下滚动
            
            if (headerDisplayHeight+self.segmentBarHeight < -newOffsetY) {
                py = -self.headerViewHeight-self.segmentBarHeight-self.currentScrollView.contentOffset.y;
                
                if (!self.allowPullToRefresh) {
                    self.headerOriginYConstraint.constant = py;
                    
                }else if (py <0) {
                    self.headerOriginYConstraint.constant = py;
                } else{
                    self.currentScrollView.hhh_startRefresh = YES;
                    self.headerOriginYConstraint.constant = 0;
                }
            }
            
        }
        
        self.contentOffset = self.currentScrollView.contentOffset;
        if ([self.delegate respondsToSelector:@selector(pagingView:scrollTopOffset:)]) {
            [self.delegate pagingView:self scrollTopOffset:self.contentOffset.y];
        }
        
        
    }else if(context == &HHHorizontalPagingViewInsetContext) {
        
        if(self.allowPullToRefresh || self.currentScrollView.contentOffset.y > -self.segmentBarHeight) {
            return;
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.headerOriginYConstraint.constant = -self.headerViewHeight-self.segmentBarHeight-self.currentScrollView.contentOffset.y;
            [self layoutIfNeeded];
            [self.headerView layoutIfNeeded];
            [self.segmentView layoutIfNeeded];
        }];
        
    }
    
}

- (void)refreshStart:(NSNotification *)notification{
    UIScrollView *obj = notification.object;
    [self.contentViewArray enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull scrollView, NSUInteger idx, BOOL * _Nonnull stop) {
      if (obj == scrollView) {
        scrollView.hhh_startRefresh = YES;
        scrollView.hhh_isRefresh = YES;
        *stop = YES;
      }
    }];
}

- (void)refreshEnd:(NSNotification *)notification{
    UIScrollView *obj = notification.object;
    [self.contentViewArray enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull scrollView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == scrollView) {
            scrollView.hhh_startRefresh = NO;
            scrollView.hhh_isRefresh = NO;
            [scrollView setDragging:NO];
            *stop = YES;
        }
    }];
}


// 视图切换时执行代码
- (void)didSwitchIndex:(NSInteger)aIndex to:(NSInteger)toIndex{
    
    self.segmentView.currenPage = toIndex;
    self.currentScrollView = [self scrollViewAtIndex:toIndex];
    
    if (aIndex == toIndex) {
        return;
    }
  
    UIScrollView *oldScrollView = [self scrollViewAtIndex:aIndex];
    if (oldScrollView.hhh_isRefresh) {
        oldScrollView.hhh_startRefresh = NO;
        oldScrollView.hhh_isRefresh = NO;
        [oldScrollView setDragging:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kHHHorizontalTakeBackRefreshEndNotification object:[self scrollViewAtIndex:aIndex]];
    }
    
    [self.segmentView setSelectedPage:toIndex];
    [self removeCacheScrollView];
  
    if ([self.delegate respondsToSelector:@selector(pagingView:didSwitchIndex:to:)]) {
      [self.delegate pagingView:self didSwitchIndex:aIndex to:toIndex];
    }
  
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    self.isScroll = YES;
    CGFloat offsetpage = scrollView.contentOffset.x/[[UIScreen mainScreen] bounds].size.width;
    CGFloat py = fabs((int)offsetpage - offsetpage);
    if ( py <= 0.3 || py >= 0.7) {
        return;
    }

    NSInteger currentPage = self.segmentView.currenSelectedPage;
    if (offsetpage - currentPage > 0) {
        if (py > 0.55) {
           [self.segmentView setSelectedPage:currentPage + 1];
        }
    }else{
        if (py < 0.45) {
            [self.segmentView setSelectedPage:currentPage - 1];
        }
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (!self.isScroll) { // 是否左右滚动  防止上下滚动的触发
        return;
    }
    
    self.isScroll = NO;
    NSInteger currentPage = scrollView.contentOffset.x/[[UIScreen mainScreen] bounds].size.width;
    [self didSwitchIndex:self.segmentView.currenPage to:currentPage];
}

- (void)removeCacheScrollView{
    
    if (self.contentViewArray.count <= self.maxCacheCout) {
        return;
    }
    [self releaseCache];
}

- (void)releaseCache{
    NSInteger currentCount = self.currentScrollView.tag;
    [self.contentViewArray enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull scrollView, NSUInteger idx, BOOL * _Nonnull stop) {
        if (labs(scrollView.tag - currentCount) > 1) {
            [self removeScrollView:scrollView];
        }
    }];
}

- (void)removeScrollView:(UIScrollView *)scrollView{
  
  [self removeObserverFor:scrollView];
  [self.contentViewArray removeObject:scrollView];
  UIViewController *vc = [self viewControllerForView:scrollView];
  vc.view.tag = 0;
  scrollView.superview.tag = 0;
  vc.view.superview.tag = 0;
  [scrollView removeFromSuperview];
  [vc.view removeFromSuperview];
  [vc removeFromParentViewController];
}

- (UIViewController *)viewControllerForView:(UIView *)view {
    for (UIView* next = view; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)removeObserverFor:(UIScrollView *)scrollView{
    [scrollView.panGestureRecognizer removeObserver:self forKeyPath:NSStringFromSelector(@selector(state)) context:&HHHorizontalPagingViewPanContext];
    [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:&HHHorizontalPagingViewScrollContext];
    [scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentInset)) context:&HHHorizontalPagingViewInsetContext];
}

- (void)dealloc {
    [self.contentViewArray enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObserverFor:obj];
    }];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 懒加载
- (UIDynamicAnimator *)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] init];
    }
    return _animator;
}

- (NSMutableArray<UIScrollView *> *)contentViewArray{
    if (!_contentViewArray) {
        _contentViewArray = [[NSMutableArray alloc] init];
    }
    return _contentViewArray;
}

- (CGFloat)maxCacheCout{
    if (_maxCacheCout == 0) {
        _maxCacheCout = 3;
    }
    return _maxCacheCout;
}


@end

