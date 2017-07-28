//
//  YFCollectionViewController.m
//  BigShow1949
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFCollectionViewController.h"

@implementation YFCollectionViewController


- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"CollectionView基本使用",@"YFNormalCollectionViewController"],
                         @[@"水平滚动布局",@"YFHorizontalScrollViewController"],
                         @[@"瀑布流布局",@"YFWaterflowViewController"],
                         @[@"RACollectionView",@"RAViewController_UIStoryboard"],]];
}

@end
