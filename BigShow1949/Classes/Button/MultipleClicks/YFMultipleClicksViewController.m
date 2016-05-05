//
//  YFMultipleClicksViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/3/16.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFMultipleClicksViewController.h"
#import "UIButton+touch.h"
//#import "UIControl+ButtonClick.h"

@interface YFMultipleClicksViewController () {
    NSInteger count;
}
@property (nonatomic, strong) UILabel *label;

@end

@implementation YFMultipleClicksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    count = 0;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    btn.timeInterval = 2;
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 200, 30)];
    self.label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.label];
    
}

- (void)btnClick:(UIButton *)button {

    count++;
    NSLog(@"%@", [NSString stringWithFormat:@"点击了按钮--- count = %zd", count]);
    self.label.text = [NSString stringWithFormat:@"点击了按钮--- count = %zd", count];
}



@end
