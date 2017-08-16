//
//  MultipleInheritanceViewController.m
//  BigShow1949
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MultipleInheritanceViewController.h"

@interface MultipleInheritanceViewController ()

@end

@implementation MultipleInheritanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDataArr:@[@[@"分类",@"MultipleCategory"],
                         @[@"组合模式",@"MultipleCombination"],
                         @[@"代理",@"MultipleDelegate"],
                         @[@"消息转发",@"MultipleMsgForawrd"],
                         @[@"协议",@"MultipleProtocol"],]];
}


@end
