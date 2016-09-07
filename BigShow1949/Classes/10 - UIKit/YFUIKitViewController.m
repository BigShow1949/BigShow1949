//
//  YFUIKitViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFUIKitViewController.h"

@interface YFUIKitViewController ()

@end

@implementation YFUIKitViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titles = @[@"Tabbar",
                    @"UIScrollView",
                    @"SearchController",
                    @"UIDynamic",
                    @"UICollectionView"];
    
    self.classNames = @[@"YFKnowledgeVC02",
                        @"YFScrollViewController",
                        @"YFSearchController",
                        @"YFDynamicViewController",
                        @"YFCollectionViewController"];
}

@end
