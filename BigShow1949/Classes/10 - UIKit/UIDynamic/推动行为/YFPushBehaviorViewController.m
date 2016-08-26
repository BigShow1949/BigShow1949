//
//  YFPushBehaviorViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFPushBehaviorViewController.h"

@interface YFPushBehaviorViewController ()
@property(nonatomic,strong)UIDynamicAnimator *animator;
@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@end

@implementation YFPushBehaviorViewController
- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 创建一个正方形
    self.squareView =[[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    [self.view addSubview:self.squareView];
    
    // 视图单机手势
    [self createGestureRecognizer];
    
    [self createAnimatorAndBehaviors];
}

- (void) createGestureRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void) handleTap:(UITapGestureRecognizer *)paramTap{
    
    CGPoint tapPoint = [paramTap locationInView:self.view];  //p2
    CGPoint squareViewCenterPoint = self.squareView.center;  //p1
    
    CGFloat deltaX = tapPoint.x - squareViewCenterPoint.x;
    CGFloat deltaY = tapPoint.y - squareViewCenterPoint.y;
    CGFloat angle = atan2(deltaY, deltaX);
    [self.pushBehavior setAngle:angle];  //推移的角度
    
    //勾股
    CGFloat distanceBetweenPoints =
    sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) +
         pow(tapPoint.y - squareViewCenterPoint.y, 2.0));
    //double pow(double x, double y）;计算以x为底数的y次幂
    //double sqrt (double);开平方
    
    //推力的大小（移动速度）
    [self.pushBehavior setMagnitude:distanceBetweenPoints / 50.0f];
    //每1个magnigude将会引起100/平方秒的加速度，这里分母越大，速度越小
    
}
- (void) createSmallSquareView{
    self.squareView =[[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    
    [self.view addSubview:self.squareView];
}
- (void) createAnimatorAndBehaviors{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    /* Create collision detection */
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]
                                      initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    self.pushBehavior = [[UIPushBehavior alloc]
                         initWithItems:@[self.squareView]
                         mode:UIPushBehaviorModeContinuous];
    
    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.pushBehavior];
}

@end
