//
//  YFImageCategoryViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/1.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFImageCategoryViewController.h"
#import "UIImage+EXtension.h"
#import "UIImage+CJZ.h"
@interface YFImageCategoryViewController ()

@end

@implementation YFImageCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    // 根据颜色创建一个图片
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
//    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    
//    // 根据颜色创建一个图片  不起作用
//    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 160, 50, 50)];
//    imgView2.backgroundColor = [UIColor lightGrayColor];
//    imgView2.image = [UIImage imageWithColor:[UIColor blueColor] size:CGSizeMake(30, 30)];
//    [self.view addSubview:imgView2];
//    
//    // 返回一张已经经过拉伸处理的图片
//    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 220, 100, 100)];
//    imgView3.backgroundColor = [UIColor lightGrayColor];
//    imgView3.image = [UIImage imageNamed:@"SenderAppNodeBkg_HL"];
//    [self.view addSubview:imgView3];
//    
//    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 220, 100, 100)];
//    imgView4.backgroundColor = [UIColor lightGrayColor];
//    imgView4.image = [UIImage stretchImageWithName:@"SenderAppNodeBkg_HL"];
//    [self.view addSubview:imgView4];
//    
//    
//    // 圆形图片
//    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 330, 50, 50)];
//    imgView5.backgroundColor = [UIColor lightGrayColor];
//    imgView5.image = [UIImage imageNamed:@"bt_star_b"];
//    [self.view addSubview:imgView5];
//    
//    UIImageView *imgView6 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 330, 50, 50)];
//    imgView6.backgroundColor = [UIColor blueColor];
//    imgView6.image = [UIImage circleImage:[UIImage imageNamed:@"bt_star_b"] withInset:10];
//    [self.view addSubview:imgView6];
    
    UIImageView *imgView7 = [[UIImageView alloc] initWithFrame:CGRectMake(130, 330, 50, 50)];
    imgView7.backgroundColor = [UIColor lightGrayColor];
//    imgView7.image = [UIImage circleImageWithName:@"ReceiverTextNodeBkg"];
    UIImage *img = [UIImage imageNamed:@"weizhifu"];
    imgView7.image = [UIImage circleImageWithImage:img borderWidth:2 borderColor:[UIColor redColor]];
    [self.view addSubview:imgView7];
    
    
// circleImageWithImage

    // circleImage
    
}


@end
