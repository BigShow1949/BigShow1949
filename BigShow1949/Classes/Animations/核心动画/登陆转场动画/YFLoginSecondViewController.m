//
//  YFLoginSecondViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFLoginSecondViewController.h"

@interface YFLoginSecondViewController ()

@end

@implementation YFLoginSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:54./256. green:70./256. blue:93./256. alpha:1.];
    
    [self createCloseButton];
}

- (void)createCloseButton
{
    UIImageView *imageview= [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"Home"];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCloseButtonTouch)];
    [imageview setUserInteractionEnabled:true];
    [imageview addGestureRecognizer:tap];
}

- (void)didCloseButtonTouch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
