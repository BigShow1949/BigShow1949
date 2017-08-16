//
//  YFExchangeMethodVC.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFExchangeMethodVC.h"
#import "UIImage+Image.h"

@interface YFExchangeMethodVC ()

@end

@implementation YFExchangeMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 本地图片 图片如果写错了,会有提示
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    imgView1.image = [UIImage imageNamed:@"4_circl"]; // 4_circle
    [self.view addSubview:imgView1];

}




@end
