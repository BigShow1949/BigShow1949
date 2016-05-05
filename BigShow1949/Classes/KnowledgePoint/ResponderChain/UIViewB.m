//
//  UIViewB.m
//  77-事件传递
//
//  Created by zhht01 on 16/3/21.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//

#import "UIViewB.h"

@implementation UIViewB

#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesBeagan..");
    
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesCancelled..");
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesEnded..");
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B - touchesMoved..");
    // 把事件传递下去给父View或包含他的ViewController
    [self.nextResponder touchesMoved:touches withEvent:event];
    
}


// 3）不让ViewB（ButtonB）收到消息
// 不让ViewB收到消息，可以设置ViewB.UserInteractionEnable=NO；除了这样还可以override掉ViewB的ponitInside，原理参考上面。
/*
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 本View不响应用户事件
    return NO;
    
}
 */

@end
