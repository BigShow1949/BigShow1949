//
//  YFCircleLoaderViewController.m
//  BigShow1949
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFCircleLoaderViewController.h"
#import "YFCircleLoader.h"

@interface YFCircleLoaderViewController ()

@end

@implementation YFCircleLoaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //设置视图大小
    CircleLoader *view=[[CircleLoader alloc]initWithFrame:CGRectMake(100, 100, 70, 70)];
    //设置轨道颜色
    view.trackTintColor=[UIColor redColor];
    //设置进度条颜色
    view.progressTintColor=[UIColor greenColor];
    //设置轨道宽度
    view.lineWidth=5.0;
    //设置进度
    view.progressValue=0.7;
    //设置是否转到 YES进度不用设置
    view.animationing=YES;
    //添加中间图片  不设置则不显示
    //    view.centerImage=[UIImage imageNamed:@"yzp_loading"];
    //添加视图
    [self.view addSubview:view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //视图隐藏
        //		[view hide];
    });
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
