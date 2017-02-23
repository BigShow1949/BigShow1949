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
    
    self.titles = @[@"Masonry基本使用",
                    @"生命周期",
                    @"响应者链条",
                    @"引导页",
                    @"运行时",
                    @"通知中心",
                    @"统计代码行数",
                    @"GCD",
                    @"KVC",
                    @"二维码",
                    @"多继承",
                    @"Quartz2D"];
    
    self.classNames = @[@"YFMasonryDemoViewController_UIStoryboard",
                        @"YFLifeCycleViewController",
                        @"YFResponderChainViewController",
                        @"YFGuideViewController",
                        @"YFRunTimeViewController",
                        @"YFNotificationCenterVC",
                        @"YFStatisticalCodeViewController",
                        @"GCDViewController",
                        @"KVCViewController",
                        @"QRCodeViewController",
                        @"MultipleInheritanceViewController",
                        @"YFQuartz2DViewController"];
}



@end
