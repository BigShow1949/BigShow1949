//
//  YFGuideViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/5/10.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFGuideViewController.h"

@implementation YFGuideViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"渐变切换",@"YFGradualChangeViewController"],
                         @[@"Keep引导页动画",@"YFKeepViewController_UIStoryboard"],]];
}
@end
