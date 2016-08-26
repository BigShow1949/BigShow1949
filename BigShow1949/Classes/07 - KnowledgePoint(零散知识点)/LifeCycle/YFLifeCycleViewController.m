//
//  YFLifeCycleViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/7.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFLifeCycleViewController.h"
#import "BViewController.h"


@interface YFLifeCycleViewController ()

@end
/*
 
 
 push:
 2016-04-05 15:04:35.841 test[919:391291] viewDidLoad--------B
 2016-04-05 15:04:35.841 test[919:391291] viewWillDisappear--------A
 2016-04-05 15:04:35.842 test[919:391291] viewWillAppear--------B
 2016-04-05 15:04:36.349 test[919:391291] viewDidDisappear--------A
 2016-04-05 15:04:36.361 test[919:391291] viewDidAppear--------B
 
 pop:
 2016-04-05 15:12:04.681 test[926:391793] viewWillDisappear--------B
 2016-04-05 15:12:04.683 test[926:391793] viewWillAppear--------A
 2016-04-05 15:12:05.191 test[926:391793] viewDidDisappear--------B
 2016-04-05 15:12:05.192 test[926:391793] viewDidAppear--------A
 
 
 
 滑动中:
 2016-04-05 15:07:26.236 test[926:391793] viewWillDisappear--------B
 2016-04-05 15:07:26.239 test[926:391793] viewWillAppear--------A
 
 
 滑动返回:
 2016-04-05 15:13:29.630 test[926:391793] viewWillDisappear--------B
 2016-04-05 15:13:29.632 test[926:391793] viewWillAppear--------A
 2016-04-05 15:13:31.664 test[926:391793] viewDidDisappear--------B
 2016-04-05 15:13:31.665 test[926:391793] viewDidAppear--------A
 
 
 滑动中不返回:
 2016-04-05 15:07:26.236 test[926:391793] viewWillDisappear--------B
 2016-04-05 15:07:26.239 test[926:391793] viewWillAppear--------A
 2016-04-05 15:07:30.357 test[926:391793] viewWillDisappear--------A
 2016-04-05 15:07:30.357 test[926:391793] viewDidDisappear--------A
 2016-04-05 15:07:30.360 test[926:391793] viewWillAppear--------B
 2016-04-05 15:07:30.360 test[926:391793] viewDidAppear--------B
 
 */
@implementation YFLifeCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad--------A");
    self.title = @"A";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)button {
    
    BViewController *bVC = [[BViewController alloc] init];
    
    //    [self presentViewController:bVC animated:YES completion:nil];
    [self.navigationController pushViewController:bVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear--------A");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear--------A");
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear--------A");
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear--------A");
}




@end
