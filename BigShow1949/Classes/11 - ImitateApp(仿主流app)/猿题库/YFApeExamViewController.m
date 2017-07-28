//
//  YFApeExamViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFApeExamViewController.h"

@interface YFApeExamViewController ()

@end

@implementation YFApeExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataArr:@[@[@"答题界面",@"YFAnswerViewController"],
                         @[@"多级cell展开",@"YFTableNodeViewController"],
                         @[@"ape展开按钮",@"YFBubbleMenuButtonViewController"],
                         @[@"系统架构",@"JLHomePracticeViewController"],]];


}



@end
