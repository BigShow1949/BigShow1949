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
    
    self.titles = @[@"CollectionView基本使用",
                    @"水平滚动布局",
                    @"瀑布流布局",
                    @"RACollectionView"];
    
    self.classNames = @[@"YFNormalCollectionViewController",
                        @"YFHorizontalScrollViewController",
                        @"YFWaterflowViewController",
                        @"RAViewController_UIStoryboard"];
}

@end
