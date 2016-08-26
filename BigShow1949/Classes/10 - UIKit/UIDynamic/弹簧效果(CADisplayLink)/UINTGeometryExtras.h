//
// Created by chris on 02.05.14.
//

#import <Foundation/Foundation.h>

static inline  CGPoint CGPointSubtract(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

static inline  CGPoint CGPointAdd(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

static inline CGPoint CGPointMultiply(CGPoint point, CGFloat multiplier)
{
    return CGPointMake(point.x * multiplier, point.y * multiplier);
}

static inline CGFloat CGPointLength(CGPoint point)
{
    return (CGFloat)sqrt(point.x * point.x + point.y * point.y);
}