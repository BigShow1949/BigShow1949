//
//  YFRippleViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/20.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFRippleViewController.h"
#import "XXBRippleView.h"

@interface YFRippleViewController ()
//@property (weak, nonatomic) IBOutlet XXBRippleView *rippleView;

@property (nonatomic, strong) XXBRippleView *rippleView;


@end

@implementation YFRippleViewController


- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 40)];
//    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
//    [startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:startBtn];
//    
//    UIButton *endBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 40)];
//    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
//    [endBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [startBtn addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:endBtn];
    
    XXBRippleView *rippleView = [[XXBRippleView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    self.rippleView = rippleView;
    [self.view addSubview:self.rippleView];
    
    [self.rippleView startRippleAnimation];
    
}

- (void)start {
    [self.rippleView startRippleAnimation];
}

- (void)end {
    [self.rippleView stopRippleAnimation];
}



@end
