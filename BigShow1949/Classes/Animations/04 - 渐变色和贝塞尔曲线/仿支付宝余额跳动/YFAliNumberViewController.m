//
//  YFAliNumberViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAliNumberViewController.h"
#import "UILabel+BezierAnimation.h"

@interface YFAliNumberViewController ()

@end

@implementation YFAliNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 100, 100, 30);
    label.backgroundColor = [UIColor lightGrayColor];
    [label animationFromnum:0 toNum:1000 duration:3];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
