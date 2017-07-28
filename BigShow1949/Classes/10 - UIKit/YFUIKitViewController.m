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
    
    [self setupDataArr:@[@[@"Tabbar",@"YFKnowledgeVC02"],
                         @[@"UIScrollView",@"YFScrollViewController"],
                         @[@"SearchController",@"YFSearchController"],
                         @[@"UIDynamic",@"YFDynamicViewController"],
                         @[@"UICollectionView",@"YFCollectionViewController"],]];
}

@end
