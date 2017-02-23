//
//  YFQuartz2DViewController.m
//  BigShow1949
//
//  Created by apple on 17/2/23.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "YFQuartz2DViewController.h"
#import "YFQuartz2DView.h"

@interface YFQuartz2DViewController ()

@end

@implementation YFQuartz2DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    YFQuartz2DView *customView = [[YFQuartz2DView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:customView];
    // Do any additional setup after loading the view.
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
