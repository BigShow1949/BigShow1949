//
//  LTSlidingViewZoomTransition.m
//  LTSlidingViewController
//
//  Created by Yu Cong on 14-10-31.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "LTSlidingViewZoomTransition.h"
#define zoom  0.88
#define finalAlpha 0.6f

@implementation LTSlidingViewZoomTransition

- (void)updateSourceView:(UIView *)sourceView destinationView:(UIView *)destView withProgress:(CGFloat)progress direction:(SlideDirection)direction
{
    CGFloat sourceViewZoom = 1 - (1 - zoom) * progress;
    sourceView.transform=CGAffineTransformMakeScale(sourceViewZoom, sourceViewZoom);
    sourceView.alpha =  1 - progress * (1 - finalAlpha);
    
    if (destView) {
        CGFloat destViewZoom = zoom + (1 - zoom) * progress;
        destView.transform=CGAffineTransformMakeScale(destViewZoom, destViewZoom);
        destView.alpha = finalAlpha + (1 - finalAlpha) * progress;
    }
}
@end
