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
    
    self.titles = @[@"网易",
                    @"微信",
                    @"猿题库",
                    @"阿里巴巴"];
    
    self.classNames = @[@"YFNeteaseViewController",
                        @"YFWeChatViewController",
                        @"YFApeExamViewController",
                        @"YFAliViewController"];
}

@end
