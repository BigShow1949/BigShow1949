//
//  YFWaterWaveViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/20.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFWaterWaveViewController.h"

@interface YFWaterWaveViewController ()

@end

@implementation YFWaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDataArr:@[@[@"放大水波纹",@"YFRippleViewController"],
                         @[@"放大水波纹2",@"YFRipple2ViewController"],
                         @[@"一条水纹",@"YFOneWaterWaveViewController"],
                         @[@"两条水纹",@"YFTwoWaterWaveViewController"],
                         @[@"水波浪",@"YFWaterRippleViewController"],]];

}


@end
