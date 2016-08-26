//
//  CloudView.m
//  CloudLabel
//
//  Created by PowerAuras on 13-9-2.
//  qq120971999  http://www.cnblogs.com/powerauras/
//  Copyright (c) 2013年 PowerAuras. All rights reserved.
//

#import "CloudView.h"
#define BUDDLEGAP_X 35
#define BUDDLEGAP_Y 10
#define FONTHEIGHT 35

#define DURATION 16

#define FIREINTERVAL 2
@interface CloudView ()
{
    NSArray *dataARy;
    NSInteger index;
}
@end
@implementation CloudView
//点击标签
-(void)touchUpInside:(UIButton *)ges{
    NSLog(@"点击");
}
//点下标签暂停动画
-(void)touchDown:(UIButton *)ges{
    CFTimeInterval pausedTime = [ges.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    ges.layer.speed = 0.0;
    ges.layer.timeOffset = pausedTime;
}
//点离标签继续动画
-(void)touchOut:(UIButton *)but{
    CFTimeInterval pausedTime = [but.layer timeOffset];
    but.layer.speed = 1.0;
    but.layer.timeOffset = 0.0;
    but.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [but.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    but.layer.beginTime = timeSincePause;
}
//根据界面宽度选择显示的标签
-(NSArray *)containThree{
    NSInteger tempIndex=index;
    
    NSObject *ob1=[dataARy objectAtModuloIndex:tempIndex];
    CGFloat width1=[(NSString *)ob1 sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(1000, FONTHEIGHT)].width;
    ++tempIndex;
    NSObject *ob2=[dataARy objectAtModuloIndex:tempIndex];
    CGFloat width2=[(NSString *)ob2 sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(1000, FONTHEIGHT)].width;
    ++tempIndex    ;
    NSObject *ob3=[dataARy objectAtModuloIndex:tempIndex];
    CGFloat width3=[(NSString *)ob3 sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(1000, FONTHEIGHT)].width;
    //如果三条显示的长度太长 就取两条显示
    if (width1+width2+width3>280) {
        //如果两条显示的长度太长 就取一条显示
        if (width1+width2>280) {
            ++index;
            return [NSArray arrayWithObject:ob1];
        }else{
            index+=2;
            return [NSArray arrayWithObjects:ob1,ob2, nil];
        }
    }else{
        index+=3;
        return [NSArray arrayWithObjects:ob1,ob2,ob3, nil];
    }
}
//动画
-(NSArray *)bubbleUp{
    index=index%[dataARy count];
    
    NSArray *temp= [self containThree];
    NSMutableArray *butAry=[NSMutableArray array];
    for (int i=0; i<[temp count]; i++) {
        NSString *thstr=[temp objectAtIndex:i];
        
        UIFont *thfont=[UIFont systemFontOfSize:16];
        
        CGFloat thstrwidth=[thstr sizeWithFont:thfont constrainedToSize:CGSizeMake(1000, FONTHEIGHT)].width;
        BubbleV *label=[[BubbleV alloc] init];
        label.frame=CGRectMake(self.frame.size.width/2-thstrwidth/2, self.frame.size.height-FONTHEIGHT, thstrwidth,FONTHEIGHT);
        [label setText:thstr];
        label.delegate=self;
        [label setFont:thfont];
        [label setTextColor:[UIColor whiteColor]];
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        [butAry addObject:label];
        [label release];
        
        CGFloat index0strwidth=[[temp objectAtIndex:0] sizeWithFont:thfont constrainedToSize:CGSizeMake(1000, FONTHEIGHT)].width;
        //如果只有两个，那么左边一个、右边一个
        if ([temp count]==2) {
            if (i==0) {
                //左边的
                CGRect rect=label.frame;
                rect.origin.x=self.frame.size.width/4-thstrwidth/2;
                rect.origin.y-=FONTHEIGHT/2;
                label.frame=rect;
            }else if(i==1){
                //右边的
                CGRect rect=label.frame;
                rect.origin.x=self.frame.size.width/4*3-thstrwidth/2;
                rect.origin.y-=FONTHEIGHT/2;
                label.frame=rect;
            }
        }else{
            //如果是有1个或者3个
            if (i==1) {
                //计算origin.x  x+width=this.origin.x
                CGRect rect=label.frame;
                rect.origin.x=self.frame.size.width/2-index0strwidth/2;
                rect.origin.x-=(thstrwidth-BUDDLEGAP_X);
                rect.origin.y-=(FONTHEIGHT-BUDDLEGAP_Y);
                label.frame=rect;
            }
            if (i==2) {
                //计算origin.x  x+width=this.origin.x
                CGRect rect=label.frame;
                rect.origin.x=self.frame.size.width/2-index0strwidth/2;
                rect.origin.x+=index0strwidth-BUDDLEGAP_X;
                rect.origin.y-=(FONTHEIGHT-BUDDLEGAP_Y);
                label.frame=rect;
            }
        }
        
        
        CABasicAnimation *basicScale=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        basicScale.fromValue=[NSNumber numberWithFloat:.65];
        basicScale.toValue=[NSNumber numberWithFloat:1.];
        basicScale.autoreverses=YES;
        basicScale.duration=DURATION/2;
        basicScale.fillMode=kCAFillModeForwards;
        basicScale.removedOnCompletion=NO;
        basicScale.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [label.layer addAnimation:basicScale forKey:@"s"];
        
        CABasicAnimation *basicOpa=[CABasicAnimation animationWithKeyPath:@"opacity"];
        basicOpa.fromValue=[NSNumber numberWithFloat:0.3];
        basicOpa.toValue=[NSNumber numberWithFloat:1.];
        basicOpa.autoreverses=YES;
        basicOpa.duration=DURATION/2;
        basicOpa.fillMode=kCAFillModeForwards;
        basicOpa.removedOnCompletion=NO;

        basicOpa.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [label.layer addAnimation:basicOpa forKey:@"o"];
        
       
        UIBezierPath *path=[UIBezierPath bezierPath];

        [path moveToPoint:CGPointMake(label.frame.origin.x+thstrwidth/2, label.frame.origin.y+FONTHEIGHT/2)];
       
        switch (i) {
            case 0:
            {
                if ([temp count]==1||[temp count]==3) {
                    //此时中间的走直线
                    [path addLineToPoint:CGPointMake(label.frame.origin.x+thstrwidth/2, FONTHEIGHT/2)];
                }else if([temp count]==2){
                    //没有中间 走左弧
                    [path addCurveToPoint:CGPointMake(label.frame.origin.x+thstrwidth/2, FONTHEIGHT/2) controlPoint1:CGPointMake(label.frame.origin.x+thstrwidth/2, label.frame.origin.y+FONTHEIGHT/2) controlPoint2:CGPointMake(0, self.frame.size.height/2)];
                }
            }
                break;
            case 1:
            {
                if ([temp count]==3) {
                    //i==1 走左弧
                    [path addCurveToPoint:CGPointMake(label.frame.origin.x+thstrwidth/2, FONTHEIGHT/2) controlPoint1:CGPointMake(label.frame.origin.x+thstrwidth/2, label.frame.origin.y+FONTHEIGHT/2) controlPoint2:CGPointMake(0, self.frame.size.height/2)];
                }else if([temp count]==2){
                    //走右弧
                    [path addCurveToPoint:CGPointMake(label.frame.origin.x+thstrwidth/2, FONTHEIGHT/2) controlPoint1:CGPointMake(label.frame.origin.x+thstrwidth/2, label.frame.origin.y+FONTHEIGHT/2) controlPoint2:CGPointMake(self.frame.size.width, self.frame.size.height/2)];

                }
            }
                break;
            case 2:
                [path addCurveToPoint:CGPointMake(label.frame.origin.x+thstrwidth/2, FONTHEIGHT/2) controlPoint1:CGPointMake(label.frame.origin.x+thstrwidth/2, label.frame.origin.y+FONTHEIGHT/2) controlPoint2:CGPointMake(self.frame.size.width, self.frame.size.height/2)];

                break;
        }

        CAKeyframeAnimation *keyPosi=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyPosi.path=path.CGPath;
        keyPosi.fillMode=kCAFillModeForwards;
        keyPosi.removedOnCompletion=NO;
        keyPosi.duration=DURATION;
        keyPosi.delegate=self;
        [keyPosi setValue:label forKeyPath:@"itslayer"];
        keyPosi.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [label.layer addAnimation:keyPosi forKey:@"x"];
        
        
    }
    return butAry;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        UIView *vie=[anim valueForKeyPath:@"itslayer"];
        [vie removeFromSuperview];
    }
}
- (void)animationDidStart:(CAAnimation *)anim{

    UIView *vie=[anim valueForKeyPath:@"itslayer"];
    NSNumber *nu=[vie valueForKeyPath:@"timeoffset"];
    if (nu!=nil) {
        vie.layer.timeOffset=nu.floatValue;
    }
    
}

-(void)reloadData:(NSArray *)ary{
    if (dataARy!=nil) {
        [dataARy release];        
    }
    dataARy=ary;
    [dataARy retain];
    //设置初始动画偏移量
    for (int i=0; i<DURATION/FIREINTERVAL; i++) {
        NSArray *buttonaRY=[self bubbleUp];
        for (UIView *vie in buttonaRY) {
            [vie setValue:[NSNumber numberWithFloat:(i+1)*FIREINTERVAL] forKeyPath:@"timeoffset"];
        }
    }
    NSTimer *tim=[NSTimer scheduledTimerWithTimeInterval:FIREINTERVAL target:self selector:@selector(bubbleUp) userInfo:nil repeats:YES];
    [tim fire];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    for (UIView *vie in self.subviews) {
        if (CGRectContainsPoint(((CALayer *)vie.layer.presentationLayer).frame, point)) {
            return vie;
        }
    }
    return nil;
}
@end
@implementation NSArray(Modulo)
- (id)objectAtModuloIndex:(NSUInteger)index{
    return [self objectAtIndex:index%[self count]];
}

@end
@implementation BubbleV
@synthesize delegate;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [delegate performSelector:@selector(touchDown:) withObject:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *tou= [touches anyObject];
    if (CGRectContainsPoint([(CALayer *)[self.layer presentationLayer] frame], [tou locationInView:self.superview])) {
        [delegate performSelector:@selector(touchUpInside:) withObject:self];
    }else{
        [delegate performSelector:@selector(touchOut:) withObject:self];
    }
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *tou= [touches anyObject];
    if (CGRectContainsPoint([(CALayer *)[self.layer presentationLayer] frame], [tou locationInView:self.superview])) {
        [delegate performSelector:@selector(touchUpInside:) withObject:self];
    }else{
        [delegate performSelector:@selector(touchOut:) withObject:self];
    }
    
}
@end