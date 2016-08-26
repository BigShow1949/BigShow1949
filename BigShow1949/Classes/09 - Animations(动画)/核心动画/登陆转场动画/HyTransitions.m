//
//  HyTransitions.m
//  Example
//
//  Created by  东海 on 15/9/2.
//  Copyright (c) 2015年 Jonathan Tribouharet. All rights reserved.
//

#import "HyTransitions.h"

@interface HyTransitions ()

@property (nonatomic,assign) NSTimeInterval transitionDuration;

@property (nonatomic,assign) CGFloat startingAlpha;

@property (nonatomic,assign) BOOL is;

@property (nonatomic,retain) id transitionContext;

@end

@implementation HyTransitions

-(instancetype) initWithTransitionDuration:(NSTimeInterval)transitionDuration StartingAlpha:(CGFloat)startingAlpha isBOOL:(BOOL)is{
    self = [super init];
    if (self) {
        _transitionDuration = transitionDuration;
        _startingAlpha = startingAlpha;
        _is = is;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{

    return _transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    if (_is) {
        toView.alpha = _startingAlpha;
        fromView.alpha = 1.0f;
        
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toView.alpha = 1.0f;
            fromView.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            fromView.alpha = 1.0f;
            [transitionContext completeTransition:true];
        }];
    }else{
        fromView.alpha = 1.0f;
        toView.alpha = 0;
        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [containerView addSubview:toView];
        [UIView animateWithDuration:0.3 animations:^{
           
            fromView.transform = CGAffineTransformMakeScale(3, 3);
            fromView.alpha = 0.0f;
            toView.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            fromView.alpha = 1.0f;
            [transitionContext completeTransition:true];
        }];
    }
}


@end
