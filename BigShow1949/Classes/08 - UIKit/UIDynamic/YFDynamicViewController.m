//
//  YFDynamicViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/8/24.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFDynamicViewController.h"

@interface YFDynamicViewController ()

@end

@implementation YFDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDataArr:@[@[@"碰撞检测",@"YFCollisionBehaviorViewController_UIStoryboard"],
                         @[@"捕捉行为",@"YFSnapBehaviorViewController"],
                         @[@"推动行为",@"YFPushBehaviorViewController"],
                         @[@"附着行为",@"YFAttachmentBehaviorViewController"],
                         @[@"动力元素行为",@"YFDynamicItemViewController"],
                         @[@"弹簧效果(附着行为)",@"YFFlexViewController"],
                         @[@"弹簧效果(CADisplayLink)",@"UINTViewController"],]];
    
}



@end
