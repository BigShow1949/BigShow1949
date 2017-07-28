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
    
    
    [self setupDataArr:@[@[@"Masonry基本使用",@"YFMasonryDemoViewController_UIStoryboard"],
                         @[@"生命周期",@"YFLifeCycleViewController"],
                         @[@"响应者链条",@"YFResponderChainViewController"],
                         @[@"引导页",@"YFGuideViewController"],
                         @[@"运行时",@"YFRunTimeViewController"],
                         @[@"通知中心",@"YFNotificationCenterVC"],
                         @[@"统计代码行数",@"YFStatisticalCodeViewController"],
                         @[@"GCD",@"GCDViewController"],
                         @[@"KVC",@"KVCViewController"],
                         @[@"二维码",@"QRCodeViewController"],
                         @[@"多继承",@"MultipleInheritanceViewController"],
                         @[@"Quartz2D",@"YFQuartz2DViewController"],
                         @[@"JS调用",@"JSViewController"]
                         ]];
    
}



@end
