//
//  YFLabelViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFLabelViewController.h"

@interface YFLabelViewController ()

@end

@implementation YFLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDataArr:@[@[@"自动布局标签",@"YFAutolayoutTagViewController_UIStoryboard"],
                         @[@"球形滚动标签",@"YFSphereTagCloud"],
                         @[@"球形滚动标签2",@"YFSphereViewController"],
                         @[@"视觉效果标签云",@"YFTagsCloudViewController_UIStoryboard"],
                         @[@"闪烁文字渐现",@"YFShineLabelViewController"],
                         @[@"闪烁文字渐现2",@"YFLazyInViewController_UIStoryboard"],
                         @[@"快播动态标签",@"YFDynamicLabelViewController"],
                         @[@"跑马灯",@"YFMarqueeViewController"],
                         @[@"打印机特效",@"YFPrinterEffectViewController"],
                         @[@"评分条",@"YFRatingBarViewController"]]];
    
}




@end
