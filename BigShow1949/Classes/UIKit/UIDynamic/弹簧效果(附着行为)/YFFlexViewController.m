//
//  YFFlexViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFFlexViewController.h"
#import "YFFlexView.h"
@implementation YFFlexViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    YFFlexView *flexView = [[YFFlexView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:flexView];
}
@end
