//
// Created by Florian on 02/05/14.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PaneBehavior.h"


@interface PaneBehavior ()

@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *itemBehavior;
@property (nonatomic, strong) id <UIDynamicItem> item;
@end


@implementation PaneBehavior

- (instancetype)initWithItem:(id <UIDynamicItem>)item
{
    self = [super init];
    if (self) {
        self.item = item;
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.item attachedToAnchor:CGPointZero];
    attachmentBehavior.frequency = 3.5;
    attachmentBehavior.damping = .4;
    attachmentBehavior.length = 0;
    [self addChildBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;

    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.item]];
    itemBehavior.density = 100;
    itemBehavior.resistance = 10;
    [self addChildBehavior:itemBehavior];
    self.itemBehavior = itemBehavior;
}

- (void)setTargetPoint:(CGPoint)targetPoint
{
    _targetPoint = targetPoint;
    self.attachmentBehavior.anchorPoint = targetPoint;
}

- (void)setVelocity:(CGPoint)velocity
{
    _velocity = velocity;
    CGPoint currentVelocity = [self.itemBehavior linearVelocityForItem:self.item];
    CGPoint velocityDelta = CGPointMake(velocity.x - currentVelocity.x, velocity.y - currentVelocity.y);
    [self.itemBehavior addLinearVelocity:velocityDelta forItem:self.item];
}

@end