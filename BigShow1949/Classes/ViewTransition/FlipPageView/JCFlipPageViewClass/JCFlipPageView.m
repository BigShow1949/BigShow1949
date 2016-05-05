//
//  JCFlipPageView.m
//  JCFlipPageView
//
//  Created by Jimple on 14-8-7.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCFlipPageView.h"
#import "JCFlipViewAnimationHelper.h"
#import "JCFlipPage.h"

static NSUInteger kReusableArraySize = 20;


@interface JCFlipPageView ()
<
    JCFlipViewAnimationHelperDataSource,
    JCFlipViewAnimationHelperDelegate
>

@property (nonatomic, strong) JCFlipViewAnimationHelper *flipAnimationHelper;

@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, strong) JCFlipPage *currPage;
@property (nonatomic, assign) NSUInteger currIndex;

@property (nonatomic, strong) NSMutableDictionary *reusablePagesDic;
@property (nonatomic, strong) NSMutableDictionary *pageIndexStr2SnapshotImgDic;

@property (nonatomic, strong) UIView *backgroundPageView;


@end

@implementation JCFlipPageView
@synthesize dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initalizeView];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initalizeView];
}

- (void)dealloc
{
    if (_currPage)
    {
        [_currPage removeFromSuperview];
    }else{}
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (NSInteger)currPageIndex
{
    return _currIndex;
}

- (void)reloadData
{
    [self cleanupPages];
    
    _currIndex = -1;
    _numberOfPages = [self pagesCount];
    if (_numberOfPages > 0)
    {
        [self flipToPageAtIndex:0 animation:NO forceFlip:YES durantion:0.3f];
    }else{}
}

- (void)flipToPageAtIndex:(NSUInteger)pageNumber animation:(BOOL)animation duration:(CGFloat)duration
{
    [self flipToPageAtIndex:pageNumber animation:animation forceFlip:YES durantion:duration];
}
- (void)flipToPageAtIndex:(NSUInteger)pageNumber animation:(BOOL)animation
{
    [self flipToPageAtIndex:pageNumber animation:animation forceFlip:NO durantion:0.3f];
}
- (void)flipToPageAtIndex:(NSUInteger)pageNumber animation:(BOOL)animation forceFlip:(BOOL)forceFlip durantion:(CGFloat)duration
{
    if (forceFlip
        || ((pageNumber < _numberOfPages) && (pageNumber != _currIndex)))
    {
        if (animation)
        {
            BOOL canDoFilpAnimation = NO;
            if (pageNumber == _currIndex)
            {// 目标页面与当前页面是同一页时无法使用动画，所以需强制把页面翻到另一页，然后才能开始动画
                if (_currIndex >= 1)
                {
                    [self filpToIndexWithoutAnimation:(_currIndex-1)];
                    canDoFilpAnimation = YES;
                }
                else if ((_currIndex + 1) < _numberOfPages)
                {
                    [self filpToIndexWithoutAnimation:(_currIndex+1)];
                    canDoFilpAnimation = YES;
                }
                else
                {
                    canDoFilpAnimation = NO;
                }
            }else{}
            
            if (canDoFilpAnimation)
            {
                [_flipAnimationHelper flipToDirection:((_currIndex > pageNumber) ? kEFlipDirectionToPrePage : kEFlipDirectionToNextPage) toPageNum:pageNumber duration:duration];
            }else{}
        }
        else
        {
            [self filpToIndexWithoutAnimation:pageNumber];
        }
    }else{}
}

- (void)filpToIndexWithoutAnimation:(NSUInteger)destPageNumber
{
    if (_currPage)
    {
        [self recoveryPage:_currPage];
    }else{}
    _currPage = nil;
    _currPage = [self.dataSource flipPageView:self pageAtIndex:destPageNumber];
    [[self reusableViewsWithReuseIdentifier:_currPage.reuseIdentifier] removeObject:_currPage];
    [self addSubview:_currPage];
    _currIndex = destPageNumber;
}

- (JCFlipPage *)dequeueReusablePageWithReuseIdentifier:(NSString *)reuseIdentifier
{
    JCFlipPage *page = [[self reusableViewsWithReuseIdentifier:reuseIdentifier] anyObject];
    if (page)
    {
        [[self reusableViewsWithReuseIdentifier:reuseIdentifier] removeObject:page];
    }else{}
    
    return page;
}

- (void)initializeBackgroundPageView:(UIView *)bgView
{
    _backgroundPageView = bgView;
    if (_flipAnimationHelper)
    {
        [_flipAnimationHelper resetBackgroundPageView:_backgroundPageView];
    }else{}
}
- (void)initializeBackgroundPageViewWithBgColor:(UIColor *)bgColor
{
    NSAssert(bgColor, @"");
    if (!bgColor)
    {
        bgColor = [UIColor clearColor];
    }else{}
    
    _backgroundPageView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundPageView.backgroundColor = bgColor;
    if (_flipAnimationHelper)
    {
        [_flipAnimationHelper resetBackgroundPageView:_backgroundPageView];
    }else{}
}

#pragma mark - JCFlipViewAnimationHelperDataSource
- (UIView *)flipViewAnimationHelperGetPreView:(JCFlipViewAnimationHelper *)helper
{
    UIView *preView;
    if (_currIndex > 0)
    {
        preView = [self.dataSource flipPageView:self pageAtIndex:_currIndex-1];
    }else{}
    
    return preView;
}

- (UIView *)flipViewAnimationHelperGetCurrentView:(JCFlipViewAnimationHelper *)helper
{
    return _currPage;
}

- (UIView *)flipViewAnimationHelperGetNextView:(JCFlipViewAnimationHelper *)helper
{
    UIView *nextView;
    if (_currIndex < (_numberOfPages - 1))
    {
        nextView = [self.dataSource flipPageView:self pageAtIndex:_currIndex+1];
    }else{}
    
    return nextView;
}

- (NSInteger)flipViewAnimationHelperGetCurrentPageIndex:(JCFlipViewAnimationHelper *)helper
{
    return _currIndex;
}

- (UIView *)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper getPageByNum:(NSUInteger)pageNum
{
    UIView *pageView;
    if (pageNum < _numberOfPages)
    {
        pageView = [self.dataSource flipPageView:self pageAtIndex:pageNum];
    }else{}
    
    return pageView;
}

- (UIImage *)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper getSnapshotForPageIndex:(NSInteger)index
{
    return _pageIndexStr2SnapshotImgDic[@(index).stringValue];
}

#pragma mark - JCFlipViewAnimationHelperDelegate
- (void)flipViewAnimationHelperBeginAnimation:(JCFlipViewAnimationHelper *)helper
{
    _currPage.hidden = YES;
}

- (void)flipViewAnimationHelperEndAnimation:(JCFlipViewAnimationHelper *)helper
{
    _currPage.hidden = NO;
}

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper flipCompletedToDirection:(EFlipDirection)direction
{
    NSUInteger newIndex = _currIndex;
    switch (direction)
    {
        case kEFlipDirectionToPrePage:
        {
            if (_currIndex >= 1)
            {
                newIndex = _currIndex - 1;
            }
            else
            {
                newIndex = 0;
            }
        }
            break;
        case kEFlipDirectionToNextPage:
        {
            if (_currIndex <= (_numberOfPages - 2))
            {
                newIndex = _currIndex + 1;
            }
            else
            {
                newIndex = _numberOfPages - 1;
            }
        }
            break;
        default:
            break;
    }
    
    [self showPage:newIndex];
}

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper flipCompletedToPage:(NSUInteger)pageNum
{
    [self showPage:pageNum];
}

- (void)flipViewAnimationHelper:(JCFlipViewAnimationHelper *)helper pageSnapshot:(UIImage *)snapshot forPageIndex:(NSInteger)index
{
    if (self.cachePageSnapshotImage && snapshot)
    {
        _pageIndexStr2SnapshotImgDic[@(index).stringValue] = snapshot;
    }else{}
}

#pragma mark -
- (void)initalizeView
{
    _pageIndexStr2SnapshotImgDic = [[NSMutableDictionary alloc] init];
    _flipAnimationHelper = [[JCFlipViewAnimationHelper alloc] initWithHostView:self backgroundPageView:_backgroundPageView];
    _flipAnimationHelper.dataSource = self;
    _flipAnimationHelper.delegate = self;
    _currIndex = -1;
    _numberOfPages = 0;
}

- (void)cleanupPages
{
    _numberOfPages = 0;
    if (_currPage)
    {
        [self recoveryPage:_currPage];
    }else{}
    _currPage = nil;
    _pageIndexStr2SnapshotImgDic = [[NSMutableDictionary alloc] init];
}

- (NSUInteger)pagesCount
{
    NSInteger count = 0;
    
    count = [self.dataSource numberOfPagesInFlipPageView:self];
    
    return count;
}

- (NSMutableSet *)reusableViewsWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (!_reusablePagesDic)
    {
        _reusablePagesDic = [[NSMutableDictionary alloc] init];
    }else{}
    NSString *reuseID = reuseIdentifier ? reuseIdentifier : kJCFlipPageDefaultReusableIdentifier;
    
    NSMutableSet *reusablePages = [_reusablePagesDic objectForKey:reuseID];
    if (!reusablePages)
    {
        reusablePages = [[NSMutableSet alloc] init];
        [_reusablePagesDic setObject:reusablePages forKey:reuseID];
    }
    return reusablePages;
}

- (void)recoveryPage:(JCFlipPage *)page
{
    if (page)
    {
        if ([self reusableViewsWithReuseIdentifier:_currPage.reuseIdentifier].count < kReusableArraySize)
        {
            [[self reusableViewsWithReuseIdentifier:_currPage.reuseIdentifier] addObject:page];
        }else{}
        [page removeFromSuperview];
        page = nil;
    }else{}
}

- (void)showPage:(CGFloat)pageIndex
{
    if (pageIndex != _currIndex)
    {
        _currIndex = pageIndex;
        if (_currPage)
        {
            [self recoveryPage:_currPage];
        }else{}
        _currPage = [self.dataSource flipPageView:self pageAtIndex:pageIndex];
        [self addSubview:_currPage];
    }else{}
}





















@end
