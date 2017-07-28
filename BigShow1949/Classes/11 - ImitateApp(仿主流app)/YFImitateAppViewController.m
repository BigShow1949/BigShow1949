//
//  YFImitateAppViewController.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/2.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFImitateAppViewController.h"

@interface YFImitateAppViewController ()

@end

@implementation YFImitateAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"网易",@"YFNeteaseViewController"],
                         @[@"微信",@"YFWeChatViewController"],
                         @[@"猿题库",@"YFApeExamViewController"],
                         @[@"阿里巴巴",@"YFAliViewController"],]];
}

@end
