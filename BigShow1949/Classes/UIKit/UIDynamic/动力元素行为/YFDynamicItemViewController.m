//
//  YFDynamicItemViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFDynamicItemViewController.h"

@interface YFDynamicItemViewController ()
@property(nonatomic,strong)UIDynamicAnimator *animator;
@property (nonatomic, strong) UIView *redView;


@end

@implementation YFDynamicItemViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(100, 100, 100, 100);
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    [self.view addSubview:redView];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self testGravityAndCollsion];
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
    //让参照视图的边框成为碰撞检测的边界
    collision.translatesReferenceBoundsIntoBoundary=YES;
    
    // 动力元素行为
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.redView]];
    itemBehavior.elasticity = 1; // 如果超过1会不停的跳
    itemBehavior.friction = 5;
    itemBehavior.density = 10;
    itemBehavior.resistance = 3; // 阻力越大,下降速度约慢,反弹约小
    itemBehavior.allowsRotation = NO;
    itemBehavior.angularResistance = 1;
    /*
     * 属性分析:
     * http://www.cnblogs.com/bigshow1949/p/5806954.html
     */
    
    //3.执行仿真
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:itemBehavior];
}


-(UIDynamicAnimator *)animator
{
    if (_animator==nil) {
        //创建物理仿真器（ReferenceView:参照视图，设置仿真范围）
        self.animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}


@end
