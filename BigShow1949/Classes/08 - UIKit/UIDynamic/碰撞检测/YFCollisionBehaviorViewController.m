//
//  YYViewController.m
//  12-重力行为和碰撞行为
//
//  Created by apple on 14-8-6.
//  Copyright (c) 2014年 yangyong. All rights reserved.
//

#import "YFCollisionBehaviorViewController.h"

@interface YFCollisionBehaviorViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UIProgressView *block1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *block2;

@property(nonatomic,strong)UIDynamicAnimator *animator;
@end

@implementation YFCollisionBehaviorViewController
-(UIDynamicAnimator *)animator
{
    if (_animator==nil) {
        //创建物理仿真器（ReferenceView:参照视图，设置仿真范围）
        self.animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //设置红色view的角度
    self.redView.transform=CGAffineTransformMakeRotation(M_PI_4);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.重力行为
//    [self testGravity];
    //2.重力行为+碰撞检测
//        [self testGravityAndCollsion];
    //3.测试重力的一些属性
    [self testGravityAndCollsion2];
    //用2根线作为边界
//    [self testGravityAndCollision3];
    //4.用圆作为边界
//    [self testGravityAndCollision4];
}

/**
 *  重力行为
 */
-(void)testGravity
{
    //1.创建仿真行为（进行怎样的仿真效果？）
    //重力行为
    UIGravityBehavior *gravity=[[UIGravityBehavior alloc] init];
    //2.添加物理仿真元素
    [gravity addItem:self.redView];
    //3.执行仿真，让物理仿真元素执行仿真行为
    [self.animator addBehavior:gravity];
}
/**
 *  重力行为+碰撞检测
 */
-(void)testGravityAndCollsion
{
    //1.重力行为
    UIGravityBehavior *gravity=[[UIGravityBehavior alloc]init];
    [gravity addItem:self.redView];
    
    //2碰撞检测行为
    UICollisionBehavior *collision=[[UICollisionBehavior alloc]init];
    [collision addItem:self.redView];
    [collision addItem:self.block1];
    [collision addItem:self.block2];
    
    //让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary=YES;
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  测试重力行为的属性
 */
-(void)testGravityAndCollsion2
{
    //1.重力行为
    UIGravityBehavior *gravity=[[UIGravityBehavior alloc]init];
    //（1）设置重力的方向（是一个角度）
    //    gravity.angle=(M_PI_2-M_PI_4);
    //（2）设置重力的加速度,重力的加速度越大，碰撞就越厉害
    gravity.magnitude=1000;
    //（3）设置重力的方向（是一个二维向量）
    gravity.gravityDirection=CGVectorMake(0, 1);
    [gravity addItem:self.redView];
    
    //2碰撞检测行为
    UICollisionBehavior *collision=[[UICollisionBehavior alloc]init];
    [collision addItem:self.redView];
    [collision addItem:self.block1];
    [collision addItem:self.block2];
    
    //让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary=YES;
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    
}

/**
 *  用圆作为边界
 */
- (void)testGravityAndCollision4
{
    // 1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.redView];
//    [gravity addItem:self.block1];
//    [gravity addItem:self.block2];
    
    // 2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.redView];
    [collision addItem:self.block1];
    [collision addItem:self.block2];
    
    // 添加一个椭圆为碰撞边界
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 320, 320)];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    // 3.开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

/**
 *  用2根线作为边界
 */
- (void)testGravityAndCollision3
{
    // 1.重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.redView];
    
    // 2.碰撞检测行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.redView];
    [collision addItem:self.block1];
    [collision addItem:self.block2];
    CGPoint startP = CGPointMake(0, 160);
    CGPoint endP = CGPointMake(320, 568);
    [collision addBoundaryWithIdentifier:@"line1" fromPoint:startP toPoint:endP];
    CGPoint startP1 = CGPointMake(320, 0);
    [collision addBoundaryWithIdentifier:@"line2" fromPoint:startP1 toPoint:endP];
    //    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 3.开始仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}
@end