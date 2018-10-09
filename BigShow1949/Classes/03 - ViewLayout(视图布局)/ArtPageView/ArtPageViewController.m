//
//  ArtPageViewController.m
//  BigShow1949
//
//  Created by big show on 2018/10/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "ArtPageViewController.h"

@interface ArtPageViewController ()

@end

@implementation ArtPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"下拉放大图片Demo",@"ArtDefaultViewController"],
                         @[@"单独下拉刷新",@"ArtPullViewController"],
                         @[@"整体下拉刷新－微信朋友圈",@"ArtWholePullViewController"],
                         @[@"headerView是一个ScrollView",@"ArtScrollHeaderViewController"],
                         @[@"导航栏变化",@"ArtChangeNavViewController"]]];
}

@end
