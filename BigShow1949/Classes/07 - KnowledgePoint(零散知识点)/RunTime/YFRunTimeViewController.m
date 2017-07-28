//
//  YFRunTimeViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFRunTimeViewController.h"

@interface YFRunTimeViewController ()

@end

@implementation YFRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"字典转模型",@"YFDictToModelViewController"],
                         @[@"分类属性",@"YFCategoryAttributeViewController"],
                         @[@"动态添加方法",@"YFAddMethodViewController"],
                         @[@"图片加载(方法交换)",@"YFExchangeMethodVC"],
                         @[@"多次点击按钮(方法交换)",@"YFMultipleClicksViewController"],
                         @[@"消息转发",@"MsgForwardingViewController"],]];
    


}



@end
