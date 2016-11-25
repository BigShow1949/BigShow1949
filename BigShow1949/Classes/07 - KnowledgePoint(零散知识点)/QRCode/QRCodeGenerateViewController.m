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
    [self.view addSubview:view];
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
