//
//  YFAttachmentBehaviorViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAttachmentBehaviorViewController.h"

@interface YFAttachmentBehaviorViewController ()

@property (nonatomic, strong) UIView *square1;
@property(nonatomic,strong)UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;



@end

@implementation YFAttachmentBehaviorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建一个正方形
    self.square1 =[[UIView alloc] initWithFrame: CGRectMake(0.0f, 568-80, 80.0f, 80.0f)];
    self.square1.backgroundColor = [UIColor greenColor];
    self.square1.center = self.view.center;
    [self.view addSubview:self.square1];
    
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    UICollisionBehavior* collision = [[UICollisionBehavior alloc] initWithItems:@[self.square1]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.square1]];
    
    
    [self.animator addBehavior:collision];
    [self.animator addBehavior:gravity];
    
    
    // 视图手势
    [self createGestureRecognizer];
}


- (void)createGestureRecognizer{
    UIPanGestureRecognizer *tapGestureRecognizer =
    [[UIPanGestureRecognizer alloc] initWithTarget:self  action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UIPanGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan){
        NSLog(@"----Began");
        
        CGPoint squareCenterPoint = CGPointMake(self.square1.center.x, self.square1.center.y - 100.0);
        
        UIAttachmentBehavior* attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.square1 attachedToAnchor:squareCenterPoint];
        
        self.attachmentBehavior = attachmentBehavior;
        [self.animator addBehavior:attachmentBehavior];
        
    } else if ( gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"----Changed");
        [self.attachmentBehavior setAnchorPoint:[gesture locationInView:self.view]];
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"----Ended");
        [self.animator removeBehavior:self.attachmentBehavior];
    }
}



@end
