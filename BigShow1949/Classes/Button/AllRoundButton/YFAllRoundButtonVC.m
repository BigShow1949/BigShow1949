//
//  YFAllRoundButtonVC.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/16.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAllRoundButtonVC.h"
#import "APRoundedButton.h"

@interface YFAllRoundButtonVC ()

@end

@implementation YFAllRoundButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
  

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];


    APRoundedButton *button = [[APRoundedButton alloc] init];
    button.style = 1;
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(50, 100, 100, 100);
    [self.view addSubview:button];
    
}



@end
