//
//  YFButtonCategoryViewController.m
//  BigShow1949
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFButtonCategoryViewController.h"
#import "UIButton+TitlePosition.h"

@interface YFButtonCategoryViewController ()

@end

@implementation YFButtonCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(20, 100, 100, 100);
        [btn setTitle:@"title" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"placeholder30"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:btn];
        [btn layoutTitleWithStyle:YFTitleStyleBottom imageTitleSpace:10];
    }
    {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(150, 100, 100, 100);
        [btn setTitle:@"title" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"placeholder30"] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:btn];
        [btn layoutTitleWithStyle:YFTitleStyleTop imageTitleSpace:10];
    }
    
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
