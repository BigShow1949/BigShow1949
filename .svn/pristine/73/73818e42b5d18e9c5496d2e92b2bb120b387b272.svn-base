//
//  LXHTwoWaterWaveController.m
//  两条水纹
//
//  Created by 李献红 on 15/12/22.
//  Copyright © 2015年 cn.lixianhong. All rights reserved.
//

#import "LXHTwoWaterWaveView.h"

@interface LXHTwoWaterWaveView ()
{
    UIColor *_waterColor1;
    UIColor *_waterColor2;
    
    float _currentLinePointY1;
    float _currentLinePointY2;
    
    float a;
    float b;
    
    BOOL flag;
}

@end

@implementation LXHTwoWaterWaveView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        a = 1.5;
        b = 0;
        flag = NO;
        
        _waterColor1 = [UIColor redColor];
        _waterColor2 = [UIColor orangeColor];
        _currentLinePointY1 = 330;
        _currentLinePointY2 = 340;
        
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)animateWave
{
    if (flag) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a <= 1) {
        flag = YES;
    }
    
    if (a >= 1.5) {
        flag = NO;
    }
    
    
    b += 0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //第一条带上面线的水纹
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGMutablePathRef path1 = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context1, 5);
    CGContextSetFillColorWithColor(context1, [_waterColor1 CGColor]);
    
    //设置上面线的颜色
    CGContextSetStrokeColorWithColor(context1, [[UIColor blueColor] CGColor]);
    
    float y1 = _currentLinePointY1;
    CGPathMoveToPoint(path1, NULL, 0, y1);
    for(float x = 0;x <= self.bounds.size.width;x++){
        y1 = a * sin( x / 180 * M_PI + 4 * b / M_PI ) * 5 + _currentLinePointY1;
        CGPathAddLineToPoint(path1, nil, x, y1);
    }
    CGContextAddPath(context1, path1);
    
    //设置画线，当然也可以不要，根据需求
    CGContextStrokePath(context1);
    
    CGPathAddLineToPoint(path1, nil, self.bounds.size.width, rect.size.height);
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path1, nil, 0, _currentLinePointY1);
    
    CGContextAddPath(context1, path1);
    CGContextFillPath(context1);
    CGPathRelease(path1);
    
    
    //第二条不带上面线的水纹
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context1, 1);
    CGContextSetFillColorWithColor(context2, [_waterColor2 CGColor]);
    
    float y2 = _currentLinePointY2;
    CGPathMoveToPoint(path2, NULL, 0, y2);
    for(float x = 0;x <= self.bounds.size.width;x++){
        y2 = a * cos(x / 180 * M_PI + 4 * b / M_PI ) * 5 + _currentLinePointY2;
        CGPathAddLineToPoint(path2, nil, x, y2);
    }
    CGContextAddPath(context2, path2);
    CGPathAddLineToPoint(path2, nil, self.bounds.size.width, rect.size.height);
    CGPathAddLineToPoint(path2, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path2, nil, 0, _currentLinePointY2);
    
    CGContextAddPath(context2, path2);
    CGContextFillPath(context2);
    CGPathRelease(path2);
   
}


@end
