//
//  BViewController.m
//  test
//
//  Created by zhht01 on 16/4/5.
//  Copyright © 2016年 BigShow1949. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"B";
    self.view.backgroundColor = [UIColor whiteColor];

    NSLog(@"viewDidLoad--------B");
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear--------B");

}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear--------B");

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear--------B");
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear--------B");

}


@end
