//
// Created by chris on 02.05.14.
//

#import "UINTSpringAnimation.h"
#import "UINTGeometryExtras.h"

@interface UINTSpringAnimation ()

@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGPoint targetPoint;
@property (nonatomic) UIView *view;

@end


@implementation UINTSpringAnimation

- (instancetype)initWithView:(UIView *)view target:(CGPoint)target velocity:(CGPoint)velocity
{
    self = [super init];
    if (self) {
        self.view = view;
        self.targetPoint = target;
        self.velocity = velocity;
    }
    return self;
}

+ (instancetype)animationWithView:(UIView *)view target:(CGPoint)target velocity:(CGPoint)velocity
{
    return [[self alloc] initWithView:view target:target velocity:velocity];
}

- (void)animationTick:(CFTimeInterval)dt finished:(BOOL *)finished
{
    static const float frictionConstant = 20;
    static const float springConstant = 300;
    CGFloat time = (CGFloat) dt;

    // friction force = velocity * friction constant
    CGPoint frictionForce = CGPointMultiply(self.velocity, frictionConstant);
    // spring force = (target point - current position) * spring constant
    CGPoint springForce = CGPointMultiply(CGPointSubtract(self.targetPoint, self.view.center), springConstant);
    // force = spring force - friction force
    CGPoint force = CGPointSubtract(springForce, frictionForce);
    // velocity = current velocity + force * time / mass
    self.velocity = CGPointAdd(self.velocity, CGPointMultiply(force, time));
    // position = current position + velocity * time
    self.view.center = CGPointAdd(self.view.center, CGPointMultiply(self.velocity, time));

    CGFloat speed = CGPointLength(self.velocity);
    CGFloat distanceToGoal = CGPointLength(CGPointSubtract(self.targetPoint, self.view.center));
    if (speed < 0.05 && distanceToGoal < 1) {
        self.view.center = self.targetPoint;
        *finished = YES;
    }
}

@end
