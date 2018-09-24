//
//  YNPageTestViewController.m
//  BigShow1949
//
//  Created by big show on 2018/9/24.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YNPageViewDemoController.h"

@interface YNPageViewDemoController ()

@end

@implementation YNPageViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupDataArr:@[@[@"测试例子",@"YFPageViewOneViewController"],
                         ]];
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
