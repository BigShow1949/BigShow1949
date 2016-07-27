//
//  YFNotificationCenterVC.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFNotificationCenterVC.h"
#import "YFNotificationCenter2VC.h"
#import "YFNotification.h"
@implementation YFNotificationCenterVC

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    
    
    [[YFNotificationCenter defaultCenter] addObserver:self selector:@selector(YFTest:) name:@"vc2" object:nil];
    [[YFNotificationCenter defaultCenter] addObserver:self selector:@selector(YFTest:) name:@"vc2" object:nil];
}

//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    [[YFNotificationCenter defaultCenter] removeObserver:self];
//}


//- (void)dealloc {
//    [[YFNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)YFTest:(YFNotification *)noti {
    
    NSLog(@"YFNotification name = %@", noti.name);
    UIButton *redButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [redButton setTitle:@"YF" forState:UIControlStateNormal];
    redButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:redButton];
}



- (void)right {

    YFNotificationCenter2VC *vc = [[YFNotificationCenter2VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
