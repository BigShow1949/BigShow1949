//
//  YFAlgorithmViewController.m
//  BigShow1949
//
//  Created by apple on 16/10/12.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAlgorithmViewController.h"

@implementation YFAlgorithmViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupDataArr:@[@[@"八皇后",@"YFEightQueensVC"],
                         @[@"汉诺塔",@"YFHanoiVC"],
                         @[@"猴子选大王",@"YFMonkeyKingVC"],
                         @[@"假金币",@"YFFalseCoinVC"],
                         @[@"各种排序对比",@"YFSortVC"],]];

}
@end
