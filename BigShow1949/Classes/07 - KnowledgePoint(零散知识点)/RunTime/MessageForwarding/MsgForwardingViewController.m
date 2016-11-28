//
//  MsgForwardingViewController.m
//  BigShow1949
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MsgForwardingViewController.h"
#import "Person_Msg.h"

@interface MsgForwardingViewController ()

@end

@implementation MsgForwardingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建Person对象 执行run方法, 但是Person类中并没有实现run方法
    // 我们利用消息转发机制防止其崩溃,或者用其他方法来代替[per run]的方法
    Person_Msg *per = [[Person_Msg alloc] init];
    [per run];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
