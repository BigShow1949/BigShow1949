//
//  BMWaveButton.m
//  Circle Button Demo
//  水波纹效果
//  Created by skyming on 14-6-25.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMWaveButton.h"

#define BMWaveButtonBorderWidth 0.0f
#define BMWaveWidth 30
#define BMWaveTypeDefaultDuration 4.0f
#define BMWaveTypeDefaultInterval 45
#define BMWaveTypeWaveDuration 4.0f
#define BMWaveTypeWaveInterval 45

@interface BMWaveButton ()

@property (nonatomic, strong) CAGradientLayer *gradientLayerTop;
@property (nonatomic, strong) CAGradientLayer *gradientLayerBottom;
@property (nonatomic, strong) CADisplayLink *waveTimer;
@end

@implementation BMWaveButton

#pragma mark- Lifecycle

- (instancetype)initWithType:(BMWaveButtonType)myType
{
    self.myButtonType = myType;
    UIWindow *window =  [UIApplication sharedApplication].windows[0];
    CGFloat midX = CGRectGetMidX(window.frame);
    CGFloat midY = CGRectGetMidY(window.frame);
    NSLog(@"MidX: %0.2f  MidY: %0.2f",midX, midY);  // 160 , 284
    
    CGRect defaultFrame = CGRectMake(midX, midY, BMWaveWidth, BMWaveWidth);
    return    [self initWithFrame:defaultFrame];
}

- (instancetype)initWithType:(BMWaveButtonType)myType Image:(NSString *)image
{
    UIImage * user =[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self setImage:user forState:UIControlStateNormal];
    self.tintColor = [UIColor whiteColor];
    
    return  [self initWithType:myType];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // border setting
        _borderColor = [UIColor whiteColor];
        _borderSize = BMWaveButtonBorderWidth;
        
        // shadowOffset
        self.layer.shadowOffset = CGSizeMake(0.25, 0.25);  //shadowOffset阴影偏移,x向右偏移0.25，y向下偏移0.25，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowRadius = 0.0;  //阴影半径，默认3
        self.layer.shadowColor = [UIColor blackColor].CGColor;  // 阴影颜色
        self.layer.shadowOpacity = 0.5; //阴影透明度，默认0
        
        // gradientLayer
        _gradientLayerTop = [CAGradientLayer layer];
        _gradientLayerTop.frame = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height / 4);
        _gradientLayerTop.colors = @[(id)[UIColor orangeColor].CGColor, (id)[[UIColor greenColor] colorWithAlphaComponent:0.01].CGColor];
        
        _gradientLayerBottom = [CAGradientLayer layer];
        _gradientLayerBottom.frame = CGRectMake(0.0, frame.size.height * 3 / 4, frame.size.width, frame.size.height / 4);
        _gradientLayerBottom.colors = @[(id)[[UIColor orangeColor] colorWithAlphaComponent:0.01].CGColor, (id)[UIColor greenColor].CGColor];
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0;
        
        if (self.myButtonType == BMWaveButtonWave) {
            _timeInterval = 35;
            _waveDuration = 4.0;
        }else{
            _timeInterval = 45;
            _waveDuration = 4.0;
        }

    }

    return self;
}

#pragma mark- Custom Accessors

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self layoutSubviews];
}
- (void)setBorderSize:(CGFloat)borderSize
{
    _borderSize = borderSize;
    [self layoutSubviews];
}
- (void)setDisplayShading:(BOOL)displayShading {
    _displayShading = displayShading;
    
    if (displayShading) {
        [self.layer addSublayer:self.gradientLayerTop];
        [self.layer addSublayer:self.gradientLayerBottom];
    } else {
        [self.gradientLayerTop removeFromSuperlayer];
        [self.gradientLayerBottom removeFromSuperlayer];
    }
    [self layoutSubviews];
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.layer.borderColor = [self.borderColor colorWithAlphaComponent:1.0].CGColor;
        [_waveTimer invalidate];
    }else
    {
        self.layer.borderColor = [self.borderColor colorWithAlphaComponent:0.7].CGColor;
        [self StartWave];
    }
}

#pragma mark- Private

- (void)updateMaskToBounds:(CGRect)maskBounds {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    CGPathRef maskPath = CGPathCreateWithEllipseInRect(maskBounds, NULL);
    
    maskLayer.bounds = maskBounds;
    maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGPoint point = CGPointMake(maskBounds.size.width/2, maskBounds.size.height/2);
    maskLayer.position = point;
    
    [self.layer setMask:maskLayer];
    
    self.layer.cornerRadius = CGRectGetHeight(maskBounds) / 2.0;
    self.layer.borderColor = [self.borderColor colorWithAlphaComponent:0.7].CGColor;
    self.layer.borderWidth = self.borderSize;
    
}

- (void)waveAnimate {
    
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    
    // accounts for left/right offset and contentOffset of scroll view
    CGPoint shapePosition = [self.superview convertPoint:self.center fromView:self.superview];
    
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = path.CGPath;
    circleShape.position = shapePosition;
    circleShape.opacity = 0;
    circleShape.strokeColor = self.borderColor.CGColor;
    
    if (self.myButtonType == BMWaveButtonDefault) {
        circleShape.lineWidth = 0.25;
        circleShape.fillColor = [UIColor clearColor].CGColor;

    }else if(self.myButtonType == BMWaveButtonWave)
    {
        circleShape.lineWidth = 0.0;
        if (self.waveColor) {
            circleShape.fillColor = self.waveColor.CGColor;
        }else{
            // 默认的填充颜色
            circleShape.fillColor = [UIColor colorWithRed:0.821 green:0.832 blue:0.842 alpha:1.000].CGColor;
        }
    }
    
    [self.superview.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    NSInteger scaleLength = 13;
    CGFloat alplaValue = 0.3;

    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scaleLength, scaleLength, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(alplaValue);
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.duration = _waveDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShape addAnimation:animation forKey:nil];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateMaskToBounds:self.bounds];
}

#pragma mark- Public
- (void)StopWave
{
    [_waveTimer invalidate];
}

- (void)StartWave
{
    
    _waveTimer = [CADisplayLink displayLinkWithTarget:self
                  
                                             selector:@selector(waveAnimate)];
    
    [_waveTimer addToRunLoop:[NSRunLoop currentRunLoop]
                     forMode:NSDefaultRunLoopMode];
    [_waveTimer setFrameInterval:_timeInterval];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
