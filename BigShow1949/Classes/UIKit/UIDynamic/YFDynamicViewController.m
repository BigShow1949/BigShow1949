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
    
    self.titles = @[@"碰撞检测",
                    @"捕捉行为",
                    @"推动行为",
                    @"附着行为",
                    @"动力元素行为",
                    @"弹簧效果(附着行为)",
                    @"弹簧效果(CADisplayLink)"];
    
    self.classNames = @[@"YFCollisionBehaviorViewController_UIStoryboard",
                        @"YFSnapBehaviorViewController",
                        @"YFPushBehaviorViewController",
                        @"YFAttachmentBehaviorViewController",
                        @"YFDynamicItemViewController",
                        @"YFFlexViewController",
                        @"UINTViewController"];

}



@end
