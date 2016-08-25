#import "Animator.h"
#import <objc/runtime.h>

static int ScreenAnimationDriverKey;

@interface Animator ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSMutableSet *animations;
@end

@implementation Animator
{
}

+ (instancetype)animatorWithScreen:(UIScreen *)screen
{
  if (!screen) {      
    screen = [UIScreen mainScreen];
  }
  Animator *driver = objc_getAssociatedObject(screen, &ScreenAnimationDriverKey);
  if (!driver) {
    driver = [[self alloc] initWithScreen:screen];
    objc_setAssociatedObject(screen, &ScreenAnimationDriverKey, driver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return driver;
}

- (instancetype)initWithScreen:(UIScreen *)screen
{
    self = [super init];
    if (self) {
        self.displayLink = [screen displayLinkWithTarget:self selector:@selector(animationTick:)];
        self.displayLink.paused = YES;
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        self.animations = [NSMutableSet new];
    }
    return self;
}

- (void)addAnimation:(id<Animation>)animation
{
    [self.animations addObject:animation];
    if (self.animations.count == 1) {
        self.displayLink.paused = NO;
    }
}

- (void)removeAnimation:(id <Animation>)animatable
{
    if (animatable == nil) return;

    [self.animations removeObject:animatable];
    if (self.animations.count == 0) {
        self.displayLink.paused = YES;
    }
}


- (void)animationTick:(CADisplayLink *)displayLink
{
    CFTimeInterval dt = displayLink.duration;
    for (id<Animation> a in [self.animations copy]) {
        BOOL finished = NO;
        [a animationTick:dt finished:&finished];
        if (finished) {
            [self.animations removeObject:a];
        }
    }
    if (self.animations.count == 0) {
        self.displayLink.paused = YES;
    }
}

@end

@implementation UIView (AnimatorAdditions)

- (Animator *)animator
{
  return [Animator animatorWithScreen:self.window.screen];
}

@end
