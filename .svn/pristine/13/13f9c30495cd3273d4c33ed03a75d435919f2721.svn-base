//
//  LTSlidingViewController.h
//
//  Created by ltebean on 14/10/31.
//  Copyright (c) 2014 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SlideDirection) {
    SlideDirectionLeft,
    SlideDirectionRight
};

@protocol LTSlidingViewTransition<NSObject>
- (void)updateSourceView:(UIView *)sourceView destinationView:(UIView *)destView withProgress:(CGFloat)progress direction:(SlideDirection)direction;
@end

@interface LTSlidingViewController: UIViewController
@property(nonatomic,strong) id<LTSlidingViewTransition>animator;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;
- (void)removeAllChildViewControllers;
- (void)didScrollToPage:(NSInteger)page;
@end
