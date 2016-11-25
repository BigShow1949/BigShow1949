//
//  QRCodeGenerateViewController.m
//  BigShow1949
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "QRCodeGenerateViewController.h"
#import "QRCodeView.h"

@interface QRCodeGenerateViewController ()

@end

@implementation QRCodeGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    QRCodeView *view = [[QRCodeView alloc] initWithFrame:CGRectMake(100, 100, 100, 100) urlString:@"https://github.com/kingsic"];
    view.centerImg = [UIImage imageNamed:@"i5"];
    view.color = [UIColor colorWithRed:200 green:201 blue:202 alpha:1];
    [self.view addSubview:view];
}

@end
