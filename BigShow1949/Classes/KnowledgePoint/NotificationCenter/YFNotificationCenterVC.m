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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSTest:) name:@"NSNotificationCenter" object:nil];
    
    [[YFNotificationCenter defaultCenter] addObserver:self selector:@selector(YFTest:) name:@"YFNotificationCenter" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:<#(nonnull id)#>];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:nil context:nil];

}

- (void)dealloc {

    [[YFNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
    [[YFNotificationCenter defaultCenter] removeObserver:self];
}

- (void)NSTest:(YFNotification *)noti {
    
    UIButton *redButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [redButton setTitle:@"NS" forState:UIControlStateNormal];
    redButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:redButton];
}

- (void)YFTest:(YFNotification *)noti {
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
