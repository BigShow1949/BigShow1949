//
//  UIViewA.m
//  77-事件传递
//
//  Created by zhht01 on 16/3/21.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//

#import "UIViewA.h"

@implementation UIViewA


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)buttonAClick:(UIButton *)button {
    
    NSLog(@"点击了buttonA----");
}
/*
 层级:
 viewA
    buttonA
    viewB
       buttonB
 */
// 1）ButtonA和ButtonB都能响应消息
// ViewB盖住了ButtonA，所以默认情况下ButtonA收不到消息，但是在消息机制里寻找消息响应是从父View开始，所以我们可以在ViewA的hitTest方法里做判断，若touch point是在ButtonA上，则将ButtonA作为消息处理对象返回。
#pragma mark - hitTest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    // 当touch point是在_btn上，则hitTest返回_btn
    CGPoint btnPointInA = [self.buttonA convertPoint:point fromView:self];
    if ([self.buttonA pointInside:btnPointInA withEvent:event]) {
        return self.buttonA;
    }
    
    // 否则，返回默认处理
    return [super hitTest:point withEvent:event];
    
}



// 2）ViewA也能收到ViewB所收到的touches消息
// ViewB只要override掉touches系列的方法，然后在自己处理完后，将消息传递给下一个响应者（即父View即ViewA）。
#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A - touchesBeagan..");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A - touchesCancelled..");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A - touchesEnded..");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A - touchesMoved..");
    
}


@end
