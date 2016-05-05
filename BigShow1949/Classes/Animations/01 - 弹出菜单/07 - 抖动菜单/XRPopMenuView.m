//
//  XRPopMenuView.m
//  MatchBox
//
//  Created by XiRuo on 15/7/22.
//  Copyright (c) 2015年 XiRuo. All rights reserved.
//

#import "XRPopMenuView.h"

#define XRPopMenuViewTag 1991

#define COLUMN_COUNT 3 //每行显示3个按钮(直接修改无效)

#define XRPopMenuViewImageHeight 70.0f
#define XRPopMenuViewTitleHeight 15.0f
#define XRPopMenuViewVerticalPadding 20.0f
#define XRPopMenuViewHorizontalMargin 10.0f
#define XRPopMenuViewImageAndTitleVerticalPadding 15.0f

#define XRPopMenuViewRriseAnimationID @"XRPopMenuViewRriseAnimationID"
#define XRPopMenuViewDismissAnimationID @"XRPopMenuViewDismissAnimationID"
#define XRPopMenuViewAnimationTime 0.2f
#define XRPopMenuViewAnimationInterval (XRPopMenuViewAnimationTime / 5)

#define viewBackColor [UIColor colorWithRed:25/255.0f green:25/255.0f blue:25/255.0f alpha:0.95]

#define kScreenWidth [UIScreen mainScreen].applicationFrame.size.width

#define kScreenHeight [UIScreen mainScreen].applicationFrame.size.height

#define WEAKSELF typeof(self) __weak weakSelf = self;


#pragma mark - XRPopMenuItemButton

@interface XRPopMenuItemButton : UIButton

@property (nonatomic,copy) XRPopMenuViewSelectedBlock selectedBlock;

@end


@implementation XRPopMenuItemButton

+ (id)XRPopMenuItemButtonWithTitle:(NSString*)title andIcon:(UIImage*)icon andSelectedBlock:(XRPopMenuViewSelectedBlock)block
{
    XRPopMenuItemButton *button = [XRPopMenuItemButton buttonWithType:UIButtonTypeCustom];
    [button setImage:icon forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    button.selectedBlock = block;
    
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(.0f, .0f, XRPopMenuViewImageHeight, XRPopMenuViewImageHeight);
    self.titleLabel.frame = CGRectMake(.0f, XRPopMenuViewImageHeight + XRPopMenuViewImageAndTitleVerticalPadding,
                                       XRPopMenuViewImageHeight, XRPopMenuViewTitleHeight);
}

@end




#pragma mark - XRPopMenuView

@interface XRPopMenuView()

@property(nonatomic,copy) XRPopMenuViewSelectedBlock selectedBlock;
@property(nonatomic,strong) UIImageView *backgroundView;
@property(nonatomic,strong) NSMutableArray *buttons;

@end


@implementation XRPopMenuView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        ges.delegate = self;
        [self addGestureRecognizer:ges];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = viewBackColor;
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
        self.buttons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addMenuItemWithTitle:(NSString*)title andIcon:(UIImage*)icon andSelectedBlock:(XRPopMenuViewSelectedBlock)block
{
    XRPopMenuItemButton *button = [XRPopMenuItemButton XRPopMenuItemButtonWithTitle:title andIcon:icon andSelectedBlock:block];
    
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

    [self.buttons addObject:button];
}

- (CGRect)frameForButtonAtIndex:(NSUInteger)index
{
    NSUInteger columnIndex =  index % COLUMN_COUNT;
    
    NSUInteger rowCount = self.buttons.count / COLUMN_COUNT + (self.buttons.count % COLUMN_COUNT > 0 ? 1 : 0);
    NSUInteger rowIndex = index / COLUMN_COUNT;
    
    CGFloat itemHeight = (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) * rowCount + (rowCount > 1 ? (rowCount - 1) * XRPopMenuViewHorizontalMargin : 0);
    
    NSInteger allButtonCount = self.buttons.count;
    NSInteger realRowCount = (allButtonCount <= 3) ? allButtonCount : 3;
    
    CGFloat offsetXPadding = (kScreenWidth - realRowCount * XRPopMenuViewImageHeight) / (realRowCount + 1);
    CGFloat offsetX = offsetXPadding;
    offsetX += (XRPopMenuViewImageHeight + offsetXPadding) * columnIndex;
    
    
    CGFloat offsetY = (CGRectGetHeight(self.frame) - itemHeight) / 2.0;
    offsetY += (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight + XRPopMenuViewVerticalPadding +
                XRPopMenuViewImageAndTitleVerticalPadding) * rowIndex;
    
    CGRect rect = CGRectMake(offsetX, offsetY, XRPopMenuViewImageHeight, (XRPopMenuViewImageHeight+XRPopMenuViewTitleHeight));
    return rect;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSUInteger i = 0; i < self.buttons.count; i++) {
        XRPopMenuItemButton *button = self.buttons[i];
        button.frame = [self frameForButtonAtIndex:i];
    }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:[XRPopMenuItemButton class]]) {
        return NO;
    }
    
    CGPoint location = [gestureRecognizer locationInView:self];
    for (UIView* subview in self.buttons) {
        if (CGRectContainsPoint(subview.frame, location)) {
            return NO;
        }
    }
    
    return YES;
}


#pragma mark - Show && Dismiss

- (void)show
{
    UIViewController *appRootViewController;
    UIWindow *window;
    
    window = [UIApplication sharedApplication].keyWindow;
    
    appRootViewController = window.rootViewController;
    
    
    UIViewController *topViewController = appRootViewController;
    while (topViewController.presentedViewController != nil)
    {
        topViewController = topViewController.presentedViewController;
    }
    
    if ([topViewController.view viewWithTag:XRPopMenuViewTag]) {
        [[topViewController.view viewWithTag:XRPopMenuViewTag] removeFromSuperview];
    }
    
    self.frame = topViewController.view.bounds;
    [topViewController.view addSubview:self];
    
    [self backViewGradualChangeByValue:1.0f animateTime:XRPopMenuViewAnimationTime];
    
    [self riseAnimation];
}


- (void)dismiss:(id)sender
{
    [self dropAnimation];
    
    double delayInSeconds = XRPopMenuViewAnimationTime  + XRPopMenuViewAnimationInterval * (self.buttons.count + 1);
    
    [self backViewGradualChangeByValue:.0f animateTime:delayInSeconds];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeFromSuperview];
    });
}

- (void)backViewGradualChangeByValue:(CGFloat)value animateTime:(CGFloat)animateTime
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animateTime];
    self.backgroundView.alpha = value;
    [UIView commitAnimations];
}

- (void)buttonTapped:(XRPopMenuItemButton*)btn
{
    //[self dismiss:nil];
    //btn.selectedBlock();

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.delegate = self;
    // 动画选项设定
    animation.duration = 0.2; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.2]; // 结束时的倍率
    
    // 添加动画
    [btn.layer addAnimation:animation forKey:@"scale-layer"];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    self.alpha = .0f;
    [UIView commitAnimations];
    
    WEAKSELF
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        btn.selectedBlock();
        [weakSelf removeFromSuperview];
    });
    
    
//    double delayInSeconds = XRPopMenuViewAnimationTime  + XRPopMenuViewAnimationInterval * (self.buttons.count + 1);
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        btn.selectedBlock();
//    });
}


- (void)riseAnimation
{
    NSUInteger rowCount = self.buttons.count / COLUMN_COUNT + (self.buttons.count%COLUMN_COUNT>0?1:0);
    
    for (NSUInteger index = 0; index < self.buttons.count; index++) {
        XRPopMenuItemButton *button = self.buttons[index];
        button.layer.opacity = 0;
        CGRect frame = [self frameForButtonAtIndex:index];
        NSUInteger rowIndex = index / COLUMN_COUNT;
        NSUInteger columnIndex = index % COLUMN_COUNT;
        CGPoint fromPosition = CGPointMake(frame.origin.x + XRPopMenuViewImageHeight / 2.0,frame.origin.y +  (rowCount - rowIndex + 2)*200 + (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) / 2.0);
        
        CGPoint toPosition = CGPointMake(frame.origin.x + XRPopMenuViewImageHeight / 2.0,frame.origin.y + (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) / 2.0);
        
        double delayInSeconds = rowIndex * COLUMN_COUNT * XRPopMenuViewAnimationInterval;
        if (!columnIndex) {
            delayInSeconds += XRPopMenuViewAnimationInterval;
        }
        else if(columnIndex == 2) {
            delayInSeconds += XRPopMenuViewAnimationInterval * 2;
        }
        
        CABasicAnimation *positionAnimation;
        
        positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.45f :1.2f :0.75f :1.0f];
        positionAnimation.duration = XRPopMenuViewAnimationTime;
        positionAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayInSeconds;
        [positionAnimation setValue:[NSNumber numberWithUnsignedInteger:index] forKey:XRPopMenuViewRriseAnimationID];
        positionAnimation.delegate = self;
        
        [button.layer addAnimation:positionAnimation forKey:@"riseAnimation"];
    }
}

- (void)dropAnimation
{
    for (NSUInteger index = 0; index < self.buttons.count; index++) {
        XRPopMenuItemButton *button = self.buttons[index];
        CGRect frame = [self frameForButtonAtIndex:index];
        NSUInteger rowIndex = index / COLUMN_COUNT;
        NSUInteger columnIndex = index % COLUMN_COUNT;
        
        CGPoint toPosition = CGPointMake(frame.origin.x + XRPopMenuViewImageHeight / 2.0,frame.origin.y +  (rowIndex + 2)*200 + (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) / 2.0);
        
        CGPoint fromPosition = CGPointMake(frame.origin.x + XRPopMenuViewImageHeight / 2.0,frame.origin.y + (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) / 2.0);
        
        double delayInSeconds = rowIndex * COLUMN_COUNT * XRPopMenuViewAnimationInterval;
        if (!columnIndex) {
            delayInSeconds += XRPopMenuViewAnimationInterval;
        }
        else if(columnIndex == 2) {
            delayInSeconds += XRPopMenuViewAnimationInterval * 2;
        }
        CABasicAnimation *positionAnimation;
        
        positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.3 :0.5f :1.0f :1.0f];
        positionAnimation.duration = XRPopMenuViewAnimationTime;
        positionAnimation.beginTime = [button.layer convertTime:CACurrentMediaTime() fromLayer:nil] + delayInSeconds;
        [positionAnimation setValue:[NSNumber numberWithUnsignedInteger:index] forKey:XRPopMenuViewDismissAnimationID];
        positionAnimation.delegate = self;
        
        [button.layer addAnimation:positionAnimation forKey:@"dropAnimation"];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:XRPopMenuViewAnimationTime];
        button.alpha = 0.5f;
        [UIView commitAnimations];
    }
}


#pragma mark - #pragma mark - XRPopMenuView

- (void)animationDidStart:(CAAnimation *)anim
{
    if([anim valueForKey:XRPopMenuViewRriseAnimationID]) {
        NSUInteger index = [[anim valueForKey:XRPopMenuViewRriseAnimationID] unsignedIntegerValue];
        UIView *view = self.buttons[index];
        CGRect frame = [self frameForButtonAtIndex:index];
        CGPoint toPosition = CGPointMake(frame.origin.x + XRPopMenuViewImageHeight / 2.0,frame.origin.y + (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) / 2.0);
        CGFloat toAlpha = 1.0;
        
        view.layer.position = toPosition;
        view.layer.opacity = toAlpha;
        
    }else if([anim valueForKey:XRPopMenuViewDismissAnimationID]) {
        NSUInteger index = [[anim valueForKey:XRPopMenuViewDismissAnimationID] unsignedIntegerValue];
        NSUInteger rowIndex = index / COLUMN_COUNT;
        
        UIView *view = self.buttons[index];
        CGRect frame = [self frameForButtonAtIndex:index];
        CGPoint toPosition = CGPointMake(frame.origin.x + XRPopMenuViewImageHeight / 2.0,frame.origin.y -  (rowIndex + 2)*250 + (XRPopMenuViewImageHeight + XRPopMenuViewTitleHeight) / 2.0);

        view.layer.position = toPosition;
    }
}


@end
