//
//  YFGradientViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFGradientViewController.h"

@interface YFGradientViewController ()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation YFGradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YFGradientViewController"]];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    //初始化渐变层
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.gradientLayer];
    
    //设置渐变颜色方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设定颜色组
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor purpleColor].CGColor];
    
    //设定颜色分割点
    self.gradientLayer.locations = @[@(0.5f) ,@(1.0f)];
    
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                  target:self
                                                selector:@selector(TimerEvent)
                                                userInfo:nil
                                                 repeats:YES];
}


- (void)TimerEvent
{
    //定时改变颜色
    self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor colorWithRed:arc4random() % 255 / 255.0
                                                               green:arc4random() % 255 / 255.0
                                                                blue:arc4random() % 255 / 255.0
                                                               alpha:1.0].CGColor];
    
    //定时改变分割点
    self.gradientLayer.locations = @[@(arc4random() % 10 / 10.0f), @(1.0f)];
}




@end
