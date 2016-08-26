//
//  CABasicAnimationViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//


#import "CABasicAnimationViewController.h"

@interface CABasicAnimationViewController ()
@property(nonatomic,strong)CALayer *myLayer;

@end

@implementation CABasicAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
     //创建layer
     CALayer *myLayer=[CALayer layer];
     //设置layer的属性
     myLayer.bounds=CGRectMake(0, 150, 50, 80);
     myLayer.backgroundColor=[UIColor yellowColor].CGColor;
     myLayer.position=CGPointMake(50, 64);
     myLayer.anchorPoint=CGPointMake(0, 0);
     myLayer.cornerRadius=20;
     //添加layer
     [self.view.layer addSublayer:myLayer];
     self.myLayer=myLayer;
}

 //设置动画（基础动画）
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.创建核心动画
    //    CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:<#(NSString *)#>]
    CABasicAnimation *anima=[CABasicAnimation animation];

     //1.1告诉系统要执行什么样的动画
     anima.keyPath=@"position";
     //设置通过动画，将layer从哪儿移动到哪儿
     anima.fromValue=[NSValue valueWithCGPoint:CGPointMake(0, 64)];
     anima.toValue=[NSValue valueWithCGPoint:CGPointMake(200, 300)];

     //1.2设置动画执行完毕之后不删除动画
     anima.removedOnCompletion=NO;
     //1.3设置保存动画的最新状态
     anima.fillMode=kCAFillModeForwards;

     //2.添加核心动画到layer
     [self.myLayer addAnimation:anima forKey:nil];

}

@end
