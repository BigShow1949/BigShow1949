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

    self.titles = @[@"分类",
                    @"组合模式",
                    @"代理",
                    @"消息转发",
                    @"协议"];
    
    self.classNames = @[@"MultipleCategory",
                        @"MultipleCombination",
                        @"MultipleDelegate",
                        @"MultipleMsgForawrd",
                        @"MultipleProtocol"];
}


@end
