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
    // 摩擦力 = 速度 * 摩擦系数
    CGPoint frictionForce = CGPointMultiply(self.velocity, frictionConstant);
    // spring force = (target point - current position) * spring constant
    // 弹力=  (目标位置 - 当前位置) * 弹簧劲度系数
    CGPoint springForce = CGPointMultiply(CGPointSubtract(self.targetPoint, self.view.center), springConstant);
    // force = spring force - friction force
    // 力 = 弹力 - 摩擦力
    CGPoint force = CGPointSubtract(springForce, frictionForce);
    // velocity = current velocity + force * time / mass
    // 速度 = 当前速度 + 力 * 时间 / 质量
    self.velocity = CGPointAdd(self.velocity, CGPointMultiply(force, time));
    // position = current position + velocity * time
    // 位置 = 当前位置 + 速度 * 时间
    self.view.center = CGPointAdd(self.view.center, CGPointMultiply(self.velocity, time));

    CGFloat speed = CGPointLength(self.velocity);
    CGFloat distanceToGoal = CGPointLength(CGPointSubtract(self.targetPoint, self.view.center));
    if (speed < 0.05 && distanceToGoal < 1) {
        self.view.center = self.targetPoint;
        *finished = YES;
    }
}

@end
