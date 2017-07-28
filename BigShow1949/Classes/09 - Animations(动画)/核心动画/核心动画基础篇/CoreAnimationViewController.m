//
//  CoreAnimationViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "CoreAnimationViewController.h"

/*
 *  具体看文顶顶的博客:http://www.cnblogs.com/wendingding/p/3801157.html
 */

@interface CoreAnimationViewController ()

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDataArr:@[@[@"基础动画",@"CABasicAnimationViewController"],
                         @[@"关键帧动画",@"CAKeyframeAnimationViewController"],
                         @[@"转场动画",@"CATransitionViewController"],
                         @[@"组动画",@"CAAnimationGroupViewController"],
                         @[@"Transform",@"CATransformViewController_UIStoryboard"],]];

}



@end
