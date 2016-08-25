//
// Created by chris on 02.05.14.
//

#import <Foundation/Foundation.h>
#import "Animator.h"


@interface UINTSpringAnimation : NSObject <Animation>

@property (nonatomic, readonly) CGPoint velocity;

+ (instancetype)animationWithView:(UIView *)view target:(CGPoint)target velocity:(CGPoint)velocity;

@end
