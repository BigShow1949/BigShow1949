//
//  UIView+Extension.m
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//  QmangoHotel
//
//  Created by Xiaol on 16/3/25.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "UIView+XLExtension.h"

@implementation UIView (XLExtension)
- (void)setXl_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)xl_x
{
    return self.frame.origin.x;
}

- (void)setXl_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)xl_y
{
    return self.frame.origin.y;
}

- (void)setXl_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)xl_width
{
    return self.frame.size.width;
}

- (void)setXl_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)xl_height
{
    return self.frame.size.height;
}

- (void)setXl_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)xl_size
{
    return self.frame.size;
}

- (void)setXl_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)xl_origin
{
    return self.frame.origin;
}


-(void)setXl_centerX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)xl_centerX{
    return self.center.x;
}

-(void)setXl_centerY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)xl_centerY{
    return self.center.y;
}



-(CGRect)coordinateInWindowView:(UIView*)superView{
    UIView *parentView = self.superview;
    CGRect rt = self.frame;
    while (parentView && parentView!=superView) {
        rt.origin.x += parentView.xl_x;
        rt.origin.y += parentView.xl_y;
        parentView = parentView.superview;
    }
    return rt;
}
@end
