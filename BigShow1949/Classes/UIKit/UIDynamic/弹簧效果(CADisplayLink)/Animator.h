@protocol Animation <NSObject>
- (void)animationTick:(CFTimeInterval)dt finished:(BOOL *)finished;
@end

@interface Animator : NSObject

+ (instancetype)animatorWithScreen:(UIScreen *)screen;

- (void)addAnimation:(id<Animation>)animatable;
- (void)removeAnimation:(id<Animation>)animatable;

@end

@interface UIView (AnimatorAdditions)

- (Animator *)animator;

@end
