//
//  YFBounceViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFBounceViewController.h"
#import "BounceView.h"
@interface YFBounceViewController ()

@end

@implementation YFBounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
    BounceView *view = [[BounceView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.frame = self.view.bounds;
    [self.view addSubview:view];

}


@end
