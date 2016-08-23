//
//  YFCircleLoader.m
//  BigShow1949
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFCircleLoader.h"
@interface CircleLoader ()
@property (nonatomic,strong) CAShapeLayer *trackLayer;
@property (nonatomic,strong) CAShapeLayer *progressLayer;
@end
@implementation CircleLoader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _trackLayer=[CAShapeLayer layer];
    _trackLayer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _trackLayer.lineWidth=_lineWidth;
    _trackLayer.strokeColor=_trackTintColor.CGColor;
    _trackLayer.fillColor = self.backgroundColor.CGColor;
    _trackLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_trackLayer];
    
    _progressLayer=[CAShapeLayer layer];
    _progressLayer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _progressLayer.lineWidth=_lineWidth;
    _progressLayer.strokeColor=_progressTintColor.CGColor;
    _progressLayer.fillColor = self.backgroundColor.CGColor;
    _progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_progressLayer];
    
    if (_centerImage!=nil) {
        UIImageView *centerImgView=[[UIImageView alloc]initWithImage:_centerImage];
        centerImgView.frame=CGRectMake(_lineWidth, _lineWidth, self.frame.size.width-2*_lineWidth, self.frame.size.height-_lineWidth*2);
        //		centerImgView.center=self.center;
        centerImgView.layer.cornerRadius=(self.frame.size.width+_lineWidth)/2;
        centerImgView.clipsToBounds=YES;
        [self.layer addSublayer:centerImgView.layer];
    }
    [self start];
}
- (void)drawBackgroundCircle:(BOOL) animationing {
    //贝塞尔曲线 0度是在十字右边方向   －M_PI/2相当于在十字上边方向
    CGFloat startAngle = - ((float)M_PI / 2); // 90 Degrees
    //
    CGFloat endAngle = (2 * (float)M_PI) + - ((float)M_PI / 8);;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - _lineWidth)/2;
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    //	processPath.lineWidth=_lineWidth;
    
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
    //	trackPath.lineWidth=_lineWidth;
    //---------------------------------------
    // Make end angle to 90% of the progress
    //---------------------------------------
    if (!animationing) {
        endAngle = (_progressValue * 2*(float)M_PI) + startAngle;
    }
    else
    {
        endAngle = (0.1 * 2*(float)M_PI) + startAngle;
    }
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [trackPath addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    _progressLayer.path = processPath.CGPath;
    _trackLayer.path=trackPath.CGPath;
}

- (void)start
{
    [self drawBackgroundCircle:_animationing];
    if (_animationing) {
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
        rotationAnimation.duration = 1;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = HUGE_VALF;
        [_progressLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
}

- (void)hide
{
    [_progressLayer removeAllAnimations];
    [self removeFromSuperview];
}
@end
