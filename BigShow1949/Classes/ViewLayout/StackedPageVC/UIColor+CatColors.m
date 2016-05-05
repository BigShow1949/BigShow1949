//
//  UIColor+CatColors.m
//  Categories Demo
//
//  Created by Stevenson on 1/20/14.
//  Copyright (c) 2014 Steven Stevenson. All rights reserved.
//

#import "UIColor+CatColors.h"

@implementation UIColor (CatColors)

+(UIColor *) tanColor {
    return [UIColor colorWithRed:225.f/255.f green:166.f/255.f blue:166.f/255.f alpha:1.f];
}

+(UIColor *) getRandomColor {
    //CGFloat r = drand48(255)/255;
    
    NSMutableArray *comps = [NSMutableArray new];
    for (int i=0;i<3;i++) {
        NSUInteger r = arc4random_uniform(256);
        CGFloat randomColorComponent = (CGFloat)r/255.f;
        [comps addObject:@(randomColorComponent)];
    }
    return [UIColor colorWithRed:[comps[0] floatValue] green:[comps[1] floatValue] blue:[comps[2] floatValue] alpha:1.0];
}

-(UIColor *)makeGreenest{
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:r green:1.0 blue:b alpha:a];
}

@end
