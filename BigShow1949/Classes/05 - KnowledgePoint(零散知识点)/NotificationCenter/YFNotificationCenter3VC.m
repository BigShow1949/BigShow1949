//
//  YFNotificationCenter3VC.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFNotificationCenter3VC.h"
#import "YFNotification.h"

@implementation YFNotificationCenter3VC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *redButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [redButton setTitle:@"点我啊" forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(redButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redButton];
}


- (void)redButtonClick:(UIButton *)btn {
    
    [[YFNotificationCenter defaultCenter] postNotificationName:@"vc3" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
