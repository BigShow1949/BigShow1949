//
//  YFKnowledgeViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 15-9-1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFKnowledgeViewController.h"


@implementation YFKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"自定义tabBar",
                    @"UISearchController",
                    @"Masonry基本使用",
                    @"生命周期",
                    @"响应者链条",
                    @"引导页",
                    @"运行时"];
    
    self.classNames = @[@"YFKnowledgeVC02",
                        @"YFSearchController",
                        @"YFMasonryDemoViewController_UIStoryboard",
                        @"YFLifeCycleViewController",
                        @"YFResponderChainViewController",
                        @"YFGuideViewController",
                        @"YFRunTimeViewController"];
}



@end
