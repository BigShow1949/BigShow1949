//
//  BounceView.m
//  KYBezierBounceView
//
//  Created by Kitten Yang on 2/17/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "BounceView.h"

@implementation BounceView{
    UIView *leftBubble;
    UIView *righBubble;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createLine];
        [self addPanGesture];
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLine];
        [self addPanGesture];
    }
    return self;
}


- (void) createLine {
    self.verticalLineLayer = [CAShapeLayer layer];
    self.verticalLineLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.verticalLineLayer.lineWidth = 1.0;
    self.verticalLineLayer.fillColor = [[UIColor whiteColor] CGColor];
    
    [self.layer addSublayer:self.verticalLineLayer];
}


- (void) addPanGesture {
    self.sgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSlide:)];
    [self addGestureRecognizer:self.sgr];
}



//左边曲线
- (CGPathRef) getLeftLinePathWithAmount:(CGFloat)amount {
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    CGPoint topPoint = CGPointMake(0, 0);
    CGPoint midControlPoint = CGPointMake(amount, self.bounds.size.height/2);
    CGPoint bottomPoint = CGPointMake(0, self.bounds.size.height);
    
    [verticalLine moveToPoint:topPoint];
    [verticalLine addQuadCurveToPoint:bottomPoint controlPoint:midControlPoint];
    [verticalLine closePath];

    return [verticalLine CGPath];
}

//右边曲线
-(CGPathRef) getRightLinePathWithAmount:(CGFloat)amount{
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    CGPoint topPoint = CGPointMake(self.bounds.size.width , 0);
    CGPoint midControlPoint = CGPointMake(self.bounds.size.width - amount, self.bounds.size.height/2);
    CGPoint bottomPoint = CGPointMake(self.bounds.size.width , self.bounds.size.height);
    
    [verticalLine moveToPoint:topPoint];
    [verticalLine addQuadCurveToPoint:bottomPoint controlPoint:midControlPoint];
    [verticalLine closePath];
    
    return [verticalLine CGPath];
}


- (void) handleSlide:(UIPanGestureRecognizer *)gr{
    CGFloat amountX = [gr translationInView:self].x;
    CGFloat amountY = [gr translationInView:self].y;
    
    
    if ( ABS(amountY) > ABS(amountX)) {
        
        [self cancelPost];
        [self cancelComment];
        return;
    }
    
    
    
    if (gr.state == UIGestureRecognizerStateChanged){
        if (amountX >= 0) {
            
            if (leftBubble == nil) {
                leftBubble = [[UIView alloc]init];
                leftBubble.center = CGPointMake(-100, self.bounds.size.height / 2);
                leftBubble.bounds = CGRectMake(0, 0, 100, 100);
                leftBubble.backgroundColor = [UIColor redColor];
                leftBubble.layer.cornerRadius = 50;
                [self addSubview:leftBubble];
            }
            
            //向右滑 ———— 转发
            [self cancelComment];
            self.verticalLineLayer.path = [self getLeftLinePathWithAmount:amountX];
            leftBubble.frame = CGRectMake(-100 + amountX*0.4, leftBubble.frame.origin.y, 100, 100);
            if (amountX > self.bounds.size.width / 2) {
                [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    leftBubble.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
                } completion:^(BOOL finished) {
                    [self cancelPost];
                }];
                [self removeGestureRecognizer:gr];
                [self animateLeftLineReturnFrom:amountX];
            }
        }else{
            if (righBubble == nil) {
                righBubble = [[UIView alloc]init];
                righBubble.center = CGPointMake(self.bounds.size.width + 100, self.bounds.size.height / 2);
                righBubble.bounds = CGRectMake(0, 0, 100, 100);
                righBubble.backgroundColor = [UIColor blueColor];
                righBubble.layer.cornerRadius = 50;
                [self addSubview:righBubble];
            }
            
            //向左滑 ———— 评论
            [self cancelPost];
            self.verticalLineLayer.path = [self getRightLinePathWithAmount:fabs(amountX)];
            righBubble.frame = CGRectMake(self.bounds.size.width  + amountX*0.4, righBubble.frame.origin.y, 100, 100);
            if (fabs(amountX) > self.bounds.size.width / 2) {
                
                [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    righBubble.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
                } completion:^(BOOL finished) {
                    [self cancelComment];
                }];
                
                [self removeGestureRecognizer:gr];
                [self animateRightLineReturnFrom:fabs(amountX)];
            }
        }
    }
    
    if (gr.state == UIGestureRecognizerStateEnded || gr.state == UIGestureRecognizerStateCancelled || gr.state == UIGestureRecognizerStateFailed) {
        [self cancelPost];
        [self cancelComment];
        if (amountX >= 0) {
            [self removeGestureRecognizer:gr];
            [self animateLeftLineReturnFrom:amountX];
        }else{
            [self removeGestureRecognizer:gr];
            [self animateRightLineReturnFrom:fabs(amountX)];
        }
    }
}

-(void)cancelPost{
    
    [UIView animateWithDuration:0.8f delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        leftBubble.center = CGPointMake(-100, self.bounds.size.height / 2);
    } completion:^(BOOL finished) {
        [leftBubble removeFromSuperview];
        leftBubble = nil;
    }];
}

-(void)cancelComment{
    
    [UIView animateWithDuration:0.8f delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        righBubble.center = CGPointMake(self.bounds.size.width + 100, self.bounds.size.height / 2);
    } completion:^(BOOL finished) {
        [righBubble removeFromSuperview];
        righBubble = nil;
    }];
}

- (void) animateLeftLineReturnFrom:(CGFloat)positionX {
    // ----- ANIMATION WITH BOUNCE
    CAKeyframeAnimation *morph = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    morph.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    NSArray *values = @[
                        (id) [self getLeftLinePathWithAmount:positionX],
                        (id) [self getLeftLinePathWithAmount:-(positionX * 0.9)],
                        (id) [self getLeftLinePathWithAmount:(positionX * 0.6)],
                        (id) [self getLeftLinePathWithAmount:-(positionX * 0.4)],
                        (id) [self getLeftLinePathWithAmount:(positionX * 0.25)],
                        (id) [self getLeftLinePathWithAmount:-(positionX * 0.15)],
                        (id) [self getLeftLinePathWithAmount:(positionX * 0.05)],
                        (id) [self getLeftLinePathWithAmount:0.0]
                        ];
    morph.values = values;
    morph.duration = 0.5;
    morph.removedOnCompletion = NO;
    morph.fillMode = kCAFillModeForwards;
    morph.delegate = self;
    [self.verticalLineLayer addAnimation:morph forKey:@"bounce_left"];
    
}

- (void) animateRightLineReturnFrom:(CGFloat)positionX {
    // ----- ANIMATION WITH BOUNCE
    CAKeyframeAnimation *morph = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    morph.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    NSArray *values = @[
                        (id) [self getRightLinePathWithAmount:positionX],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.9)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.6)],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.4)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.25)],
                        (id) [self getRightLinePathWithAmount:-(positionX * 0.15)],
                        (id) [self getRightLinePathWithAmount:(positionX * 0.05)],
                        (id) [self getRightLinePathWithAmount:0.0]
                        ];
    morph.values = values;
    morph.duration = 0.5;
    morph.removedOnCompletion = NO;
    morph.fillMode = kCAFillModeForwards;
    morph.delegate = self;
    [self.verticalLineLayer addAnimation:morph forKey:@"bounce_right"];
}



#pragma mark  - CAAnimationDelegate
- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == [self.verticalLineLayer animationForKey:@"bounce_left"] ) {
        self.verticalLineLayer.path = [self getLeftLinePathWithAmount:0.0];
        [self.verticalLineLayer removeAllAnimations];
        [self addPanGesture];
    }else if(anim == [self.verticalLineLayer animationForKey:@"bounce_right"]){
        self.verticalLineLayer.path = [self getRightLinePathWithAmount:0.0];
        [self.verticalLineLayer removeAllAnimations];
        [self addPanGesture];
    }
}

@end
