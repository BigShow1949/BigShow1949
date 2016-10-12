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
    self.titles = @[@"八皇后",
                    @"汉诺塔",
                    @"猴子选大王",
                    @"假金币",
                    @"各种排序对比"];
    
    
    self.classNames = @[@"YFEightQueensVC",
                        @"YFHanoiVC",
                        @"YFMonkeyKingVC",
                        @"YFFalseCoinVC",
                        @"YFSortVC"];
}
@end
