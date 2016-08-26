//
//  JCFlipViewAnimationHelper.m
//  JCFlipPageView
//
//  Created by Jimple on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCFlipViewAnimationHelper.h"
#import "SBGradientOverlayLayer.h"      // layer加阴影直接使用SBTickerView的代码 https://github.com/blommegard/SBTickerView


#define kDefaultBgPageColor             [UIColor darkGrayColor]
#define kProgressAnimationDuration      0.5f
#define kSwipeReduceRate                0.8f
#define kFlipToBgMaxProgress            0.3f

@interface JCFlipViewAnimationHelper ()

@property (nonatomic, weak) UIView *hostView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) BOOL canBeginAnimateWithPan;
@property (nonatomic, assign) BOOL isAnimatingWithPan;
@property (nonatomic, assign) BOOL isAnimationCompleted;
@property (nonatomic, assign) BOOL isAnimationInited;
@property (nonatomic, assign) EFlipDirection currFlipDirection;
@property (nonatomic, assign) CGFloat startFlipAngle;
@property (nonatomic, assign) CGFloat endFlipAngle;
@property (nonatomic, assign) CGFloat currentAngle;

@property (nonatomic, strong) CALayer *panelLayer;
@property (nonatomic, strong) CATransformLayer *flipLayer;

@property (nonatomic, strong) SBGradientOverlayLayer *bgTopLayer;
@property (nonatomic, strong) SBGradientOverlayLayer *bgBottomLayer;
@property (nonatomic, strong) SBGradientOverlayLayer *flipFrontSubLayer;
@property (nonatomic, strong) SBGradientOverlayLayer *flipBackSubLayer;

@property (nonatomic, strong) UIImage *backgroundPageSnapshot;
@property (nonatomic, strong) UIView *bgPageView;
@property (nonatomic, assign) BOOL isFilpToBg;

@end

@implementation JCFlipViewAnimationHelper
@synthesize dataSource;
@synthesize delegate;

- (instancetype)initWithHostView:(UIView *)hostView backgroundPageView:(UIView *)bgPageView
{
    self = [super init];
    if (self)
    {
        NSAssert(hostView, @"");
        _hostView = hostView;
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        [_hostView addGestureRecognizer:_panGesture];
        
        _canBeginAnimateWithPan = YES;
        _isAnimationCompleted = YES;
        _isAnimatingWithPan = NO;
        _isAnimationInited = NO;
        _isFilpToBg = NO;
        
        [self resetBackgroundPageView:bgPageView];
    }else{}
    return self;
}

- (void)dealloc
{
    [_hostView removeGestureRecognizer:_panGesture];
    [self clearLayers];
}

- (void)resetBackgroundPageView:(UIView *)bgView
{
    _bgPageView = bgView;
    [self initializeBgPageSnapshot];
}

- (void)flipToDirection:(EFlipDirection)direction toPageNum:(NSUInteger)pageNum
{
    [self flipToDirection:direction toPageNum:pageNum duration:0.3f];
}
- (void)flipToDirection:(EFlipDirection)direction toPageNum:(NSUInteger)pageNum duration:(CGFloat)duration
{
    [self clearLayers];
    _canBeginAnimateWithPan = YES;
    _isAnimationCompleted = YES;
    _isAnimatingWithPan = NO;
    _isAnimationInited = NO;
    
    _currFlipDirection = direction;
    [self beginFlipAnimationForDirection:_currFlipDirection flipToDestPage:YES destPageNum:pageNum];

    _canBeginAnimateWithPan = NO;
    _isAnimationCompleted = NO;
    [self performSelector:@selector(delayShowFlipAnimation:) withObject:@[@(duration), @(pageNum)] afterDelay:0.01f];
}

- (void)delayShowFlipAnimation:(NSArray *)paramArray
{
    NSNumber *duration = paramArray[0];
    NSNumber *pageNum = paramArray[1];
    [self progressFlipAnimation:1.0f duration:duration.floatValue cleanupWhenCompleted:YES isDelegatePageNum:YES destPageNum:pageNum.unsignedIntegerValue];
}

#pragma mark - Gesture handler
- (void)panGestureHandler:(UIPanGestureRecognizer *)recognizer
{
    if (!_canBeginAnimateWithPan)
    {
        return;
    }else{}
    
    CGFloat translationY = [recognizer translationInView:_hostView].y;
    
	switch (recognizer.state)
    {
		case UIGestureRecognizerStateBegan:
        {
            if (_isAnimationCompleted)
            {
                _isAnimationCompleted = NO;
                _isAnimatingWithPan = YES;
            }else{}
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (_isAnimatingWithPan)
            {
                BOOL canProgressAnimation = YES;
                if (!_isAnimationInited)
                {
                    _currFlipDirection = ((translationY > 0.0f) ? kEFlipDirectionToPrePage : kEFlipDirectionToNextPage);
                    canProgressAnimation = [self beginFlipAnimationForDirection:_currFlipDirection];
                }else{}
                
                if (canProgressAnimation)
                {
                    CGFloat progress = translationY / (_hostView.bounds.size.height * kSwipeReduceRate);    // height * 小于1的数，减小手指滑动的行程
                    switch (_currFlipDirection)
                    {
                        case kEFlipDirectionToPrePage:
                        {
                            progress = MAX(progress, 0);
                            progress = MIN(progress, 1.0f);
                        }
                            break;
                        case kEFlipDirectionToNextPage:
                        {
                            progress = MIN(progress, 0);
                            progress = MAX(progress, -1.0f);
                        }
                            break;
                        default:
                            break;
                    }
                    progress = fabsf(progress);
                    
                    // 从第一页向前翻或者最后一页向后翻，都认为是要翻到背景页。
                    // 只能翻起一部分，以表示不能再继续翻页了。
                    if (_isFilpToBg)
                    {
                        progress = progress * kFlipToBgMaxProgress;
                    }else{}
                    
                    [self progressFlipAnimation:progress];
                }
                else
                {
                    [self endFlipAnimation];
                }
            }else{}
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            if (_isAnimatingWithPan)
            {
                [self progressFlipAnimation:0.0f cleanupWhenCompleted:YES];
            }else{}
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            if (_isAnimatingWithPan)
            {
                [self endFlipAnimation];
            }else{}
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (_isAnimatingWithPan)
            {
                if (_isFilpToBg)
                {
                    [self progressFlipAnimation:0.0f cleanupWhenCompleted:YES];
                }
                else
                {
                    // 翻页超过一半则继续完成翻页，否则翻回原来页面
                    if (fabs((translationY + [recognizer velocityInView:_hostView].y / 4) / _hostView.bounds.size.height) > 0.5f)
                    {
                        [self progressFlipAnimation:1.0f cleanupWhenCompleted:YES];
                    }
                    else
                    {
                        [self progressFlipAnimation:0.0f cleanupWhenCompleted:YES];
                    }
                }
            }else{}
        }
            break;
        default:
        {
        }
            break;
    }
}

#pragma mark -
- (BOOL)beginFlipAnimationForDirection:(EFlipDirection)direction
{
    return [self beginFlipAnimationForDirection:direction flipToDestPage:NO destPageNum:0];
}
- (BOOL)beginFlipAnimationForDirection:(EFlipDirection)direction flipToDestPage:(BOOL)isFlipToDestPage destPageNum:(NSUInteger)destPageNum
{
    BOOL canFlipPage = NO;
    NSAssert(self.dataSource, @"");
    
    // 获取当前页和目标页的视图、页码
    UIView *currView;
    UIView *preView;
    UIView *nextView;
    NSInteger currViewIndex = [self.dataSource flipViewAnimationHelperGetCurrentPageIndex:self];
    NSInteger preViewIndex = currViewIndex - 1;
    NSInteger nextViewIndex = currViewIndex + 1;
    
    currView = [self.dataSource flipViewAnimationHelperGetCurrentView:self];
    switch (direction)
    {
        case kEFlipDirectionToPrePage:
        {
            if (isFlipToDestPage)
            {
                preView = [self.dataSource flipViewAnimationHelper:self getPageByNum:destPageNum];
                preViewIndex = destPageNum;
            }
            else
            {
                preView = [self.dataSource flipViewAnimationHelperGetPreView:self];
                if (preView)
                {
                    preViewIndex = currViewIndex - 1;
                }else{}
            }
            
            canFlipPage = (preView != nil);
        }
            break;
        case kEFlipDirectionToNextPage:
        {
            if (isFlipToDestPage)
            {
                nextView = [self.dataSource flipViewAnimationHelper:self getPageByNum:destPageNum];
                nextViewIndex = destPageNum;
            }
            else
            {
                nextView = [self.dataSource flipViewAnimationHelperGetNextView:self];
                if (nextView)
                {
                    nextViewIndex = currViewIndex + 1;
                }else{}
            }
            canFlipPage = (nextView != nil);
        }
            break;
        default:
            break;
    }
    
    // 从第一页向前翻或者最后一页向后翻，都认为是要翻到背景页。
    _isFilpToBg = NO;
    if (!canFlipPage && !isFlipToDestPage)
    {
        if (direction == kEFlipDirectionToPrePage)
        {
            preView = _bgPageView;
            canFlipPage = YES;
            _isFilpToBg = YES;
        }
        else if (direction == kEFlipDirectionToNextPage)
        {
            nextView = _bgPageView;
            canFlipPage = YES;
            _isFilpToBg = YES;
        }else{}
    }else{}
    
    if ((currViewIndex < 0) || !currView)
    {
        canFlipPage = NO;
    }else{}
    
    // 初始化翻页需要使用的页面截图和layer
    if (canFlipPage && currView)
    {
        [self rebulidLayers];
        
        _bgTopLayer.contentsGravity = kCAGravityBottom;
        _bgBottomLayer.contentsGravity = kCAGravityTop;
        _flipFrontSubLayer.contentsGravity = kCAGravityBottom;
        _flipBackSubLayer.contentsGravity = kCAGravityTop;
        
        switch (direction)
        {
            case kEFlipDirectionToPrePage:
            {
                UIImage *preImg;
                if (preView == _bgPageView)
                {
                    preImg = _backgroundPageSnapshot;
                }
                else
                {
                    preImg = [self.dataSource flipViewAnimationHelper:self getSnapshotForPageIndex:preViewIndex];
                    if (!preImg)
                    {
                        preImg = [self snapshotFromView:preView];
                        [self.delegate flipViewAnimationHelper:self pageSnapshot:preImg forPageIndex:preViewIndex];
                    }else{}
                }
                
                UIImage *currImg = [self snapshotFromView:currView];
                if (!currImg)
                {
                    currImg = [self snapshotFromView:currView];
                    [self.delegate flipViewAnimationHelper:self pageSnapshot:currImg forPageIndex:currViewIndex];
                }else{}
                
                [_bgTopLayer setContents:(__bridge id)preImg.CGImage];
                [_bgBottomLayer setContents:(__bridge id)currImg.CGImage];
                [_flipFrontSubLayer setContents:(__bridge id)currImg.CGImage];
                [_flipBackSubLayer setContents:(__bridge id)preImg.CGImage];
                
                [_flipLayer setTransform:CATransform3DIdentity];
                
                _currentAngle = _startFlipAngle = 0.0f;
                _endFlipAngle = -M_PI;
            }
                break;
            case kEFlipDirectionToNextPage:
            {
                UIImage *nextImg;
                if (nextView == _bgPageView)
                {
                    nextImg = _backgroundPageSnapshot;
                }
                else
                {
                    nextImg = [self.dataSource flipViewAnimationHelper:self getSnapshotForPageIndex:nextViewIndex];
                    if (!nextImg)
                    {
                        nextImg = [self snapshotFromView:nextView];
                        [self.delegate flipViewAnimationHelper:self pageSnapshot:nextImg forPageIndex:nextViewIndex];
                    }else{}
                }
                
                UIImage *currImg = [self snapshotFromView:currView];
                if (!currImg)
                {
                    currImg = [self snapshotFromView:currView];
                    [self.delegate flipViewAnimationHelper:self pageSnapshot:currImg forPageIndex:currViewIndex];
                }else{}
                
                [_bgTopLayer setContents:(__bridge id)currImg.CGImage];
                [_bgBottomLayer setContents:(__bridge id)nextImg.CGImage];
                [_flipFrontSubLayer setContents:(__bridge id)nextImg.CGImage];
                [_flipBackSubLayer setContents:(__bridge id)currImg.CGImage];

                [_flipLayer setTransform:CATransform3DMakeRotation(-M_PI, 1., 0., 0.)];
                
                _currentAngle = _startFlipAngle = -M_PI;
                _endFlipAngle = 0.0f;
            }
                break;
            default:
                break;
        }
        
        _isAnimationInited = YES;
        
        if (delegate && [delegate respondsToSelector:@selector(flipViewAnimationHelperBeginAnimation:)])
        {
            [delegate flipViewAnimationHelperBeginAnimation:self];
        }else{}
    }else{}

    return canFlipPage;
}

- (void)progressFlipAnimation:(CGFloat)progress
{
    [self progressFlipAnimation:progress cleanupWhenCompleted:NO];
}
- (void)progressFlipAnimation:(CGFloat)progress cleanupWhenCompleted:(BOOL)isCleanupWhenCompleted
{
    [self progressFlipAnimation:progress duration:0.0f cleanupWhenCompleted:isCleanupWhenCompleted];
}
- (void)progressFlipAnimation:(CGFloat)progress duration:(CGFloat)animationDuration cleanupWhenCompleted:(BOOL)isCleanupWhenCompleted
{
    [self progressFlipAnimation:progress duration:animationDuration cleanupWhenCompleted:isCleanupWhenCompleted isDelegatePageNum:NO destPageNum:0];
}
- (void)progressFlipAnimation:(CGFloat)progress duration:(CGFloat)animationDuration cleanupWhenCompleted:(BOOL)isCleanupWhenCompleted isDelegatePageNum:(BOOL)isDelegatePageNum destPageNum:(NSUInteger)destPageNum
{
    CGFloat newAngle = _startFlipAngle + progress * (_endFlipAngle - _startFlipAngle);
	CATransform3D endTransform = CATransform3DIdentity;
	endTransform.m34 = 1.0f / 2500.0f;
	endTransform = CATransform3DRotate(endTransform, newAngle, -1.0, 0.0, 0.0);
	
    CGFloat duration = (animationDuration > 0.0f) ? animationDuration : (kProgressAnimationDuration * fabs((newAngle - _currentAngle) / (_endFlipAngle - _startFlipAngle)));
    
    _currentAngle = newAngle;
    
	[_flipLayer removeAllAnimations];
    
	[CATransaction begin];
	[CATransaction setAnimationDuration:duration];
    
    if (isCleanupWhenCompleted)
    {
        __weak __typeof(self)weakSelf = self;
        [CATransaction setCompletionBlock:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            [strongSelf endFlipAnimation];
            
            if (progress >= 1.0f)
            {
                if (isDelegatePageNum)
                {
                    if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(flipViewAnimationHelper:flipCompletedToPage:)])
                    {
                        [strongSelf.delegate flipViewAnimationHelper:self flipCompletedToPage:destPageNum];
                    }else{}
                }
                else if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(flipViewAnimationHelper:flipCompletedToDirection:)])
                {
                    [strongSelf.delegate flipViewAnimationHelper:self flipCompletedToDirection:_currFlipDirection];
                }else{}
            }else{}
        }];
    }else{}
    
	_flipLayer.transform = endTransform;
    
    // 翻页时的阴影变化：即将被覆盖的部分越来越暗，即将展示的部分越来越亮。
    if (_startFlipAngle == 0.0f)
    {// 从上向下翻
        _bgTopLayer.gradientOpacity = 1.0f -progress;
        _bgBottomLayer.gradientOpacity = progress;
        
        _flipFrontSubLayer.gradientOpacity = progress;
        _flipBackSubLayer.gradientOpacity = 1.0f - progress;
    }
    else
    {// 从下向上翻
        _bgTopLayer.gradientOpacity = progress;
        _bgBottomLayer.gradientOpacity = 1.0f - progress;
        
        _flipFrontSubLayer.gradientOpacity = 1.0f - progress;
        _flipBackSubLayer.gradientOpacity = progress;
    }
    
	[CATransaction commit];
}

- (void)endFlipAnimation
{
    [self clearLayers];
    
    _canBeginAnimateWithPan = YES;
    _isAnimationCompleted = YES;
    _isAnimatingWithPan = NO;
    _isAnimationInited = NO;
    _isFilpToBg = NO;
    
    if (delegate && [delegate respondsToSelector:@selector(flipViewAnimationHelperEndAnimation:)])
    {
        [delegate flipViewAnimationHelperEndAnimation:self];
    }else{}
}

- (void)clearLayers
{
    if (_bgTopLayer)
    {
        [_bgTopLayer removeFromSuperlayer];
        _bgTopLayer = nil;
    }else{}
    
    if (_bgBottomLayer)
    {
        [_bgBottomLayer removeFromSuperlayer];
        _bgBottomLayer = nil;
    }else{}
    
    if (_flipFrontSubLayer)
    {
        [_flipFrontSubLayer removeFromSuperlayer];
        _flipFrontSubLayer = nil;
    }else{}
    
    if (_flipBackSubLayer)
    {
        [_flipBackSubLayer removeFromSuperlayer];
        _flipBackSubLayer = nil;
    }else{}
    
    if (_flipLayer)
    {
        [_flipLayer removeAllAnimations];
        [_flipLayer removeFromSuperlayer];
        _flipLayer = nil;
    }else{}
    
    if (_panelLayer)
    {
        [_panelLayer removeFromSuperlayer];
        _panelLayer = nil;
    }else{}
}

- (void)rebulidLayers
{
    [self clearLayers];
    
    _panelLayer = [CALayer layer];
    _panelLayer.frame = _hostView.layer.bounds;
    [_hostView.layer addSublayer:_panelLayer];
    
    _bgTopLayer = [[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeFace
                                                        segment:SBGradientOverlayLayerSegmentTop];
    _bgTopLayer.frame = CGRectMake(0.0f, 0.0f, _panelLayer.bounds.size.width, _panelLayer.bounds.size.height/2.0f);
    _bgTopLayer.doubleSided = NO;
    _bgTopLayer.masksToBounds = YES;
    _bgTopLayer.contentsScale = [[UIScreen mainScreen] scale];
    [_panelLayer addSublayer:_bgTopLayer];
    
    _bgBottomLayer = [[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeFace
                                                           segment:SBGradientOverlayLayerSegmentBottom];
    _bgBottomLayer.frame = CGRectMake(0.0f, _panelLayer.bounds.size.height/2.0f, _panelLayer.bounds.size.width, _panelLayer.bounds.size.height/2.0f);
    _bgBottomLayer.doubleSided = NO;
    _bgBottomLayer.masksToBounds = YES;
    _bgBottomLayer.contentsScale = [[UIScreen mainScreen] scale];
    [_panelLayer addSublayer:_bgBottomLayer];
    
    _flipLayer = [CATransformLayer layer];
    _flipLayer.doubleSided = YES;
    _flipLayer.anchorPoint = CGPointMake(1., 1.);
    _flipLayer.frame = CGRectMake(0.0f, 0.0f, _panelLayer.frame.size.width, (_panelLayer.frame.size.height/2));
    _flipLayer.zPosition = 1000.0f; // Above the other ones
    [_panelLayer addSublayer:_flipLayer];
    
    _flipFrontSubLayer = [[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeFace
                                                               segment:SBGradientOverlayLayerSegmentTop];
    _flipFrontSubLayer.frame = _flipLayer.bounds;
    _flipFrontSubLayer.doubleSided = NO;
    _flipFrontSubLayer.masksToBounds = YES;
    _flipFrontSubLayer.contentsScale = [[UIScreen mainScreen] scale];
    [_flipLayer addSublayer:_flipFrontSubLayer];
    
    _flipBackSubLayer = [[SBGradientOverlayLayer alloc] initWithStyle:SBGradientOverlayLayerTypeFace
                                                              segment:SBGradientOverlayLayerSegmentBottom];
    _flipFrontSubLayer.frame = _flipLayer.bounds;
    _flipBackSubLayer.frame = _flipLayer.bounds;
    _flipBackSubLayer.doubleSided = NO;
    _flipBackSubLayer.masksToBounds = YES;
    _flipBackSubLayer.contentsScale = [[UIScreen mainScreen] scale];
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 1., 0., 0.);
    [_flipBackSubLayer setTransform:transform];
    [_flipLayer addSublayer:_flipBackSubLayer];
}

- (UIImage*)snapshotFromView:(UIView *)view
{
	UIImage *image = nil;
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return image;
}

- (void)initializeBgPageSnapshot
{
    if (!_bgPageView)
    {
        _bgPageView = [[UIView alloc] initWithFrame:_hostView.bounds];
        _bgPageView.backgroundColor = kDefaultBgPageColor;
    }else{}
    _backgroundPageSnapshot = [self snapshotFromView:_bgPageView];
}

























@end
