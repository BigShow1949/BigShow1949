//
//  YFAnimationVC02.m
//  BigShow1949
//
//  Created by WangMengqi on 15/9/1.
//  Copyright (c) 2015年 BigShowCompany. All rights reserved.
//

#import "YFAnimationVC02.h"
#import "YFRotateCircleMenuVC.h"

@interface YFAnimationVC02 ()
@property (nonatomic, strong) YFRotateCircleMenuVC *viewController;

@end

@implementation YFAnimationVC02

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    self.title = @"5个旋转菜单";
    
    YFRotateCircleMenuVC *viewController = [[YFRotateCircleMenuVC alloc] init];
    [self.view addSubview:viewController.view];
    [self addChildViewController:viewController];
    [viewController didMoveToParentViewController:self];
    self.viewController = viewController;
}

- (void)dealloc {
    
    [_viewController.view removeFromSuperview];
    [_viewController removeFromParentViewController];
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
