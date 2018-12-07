//
//  YFToDoBaseViewController.m
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoBaseViewController.h"
#import "YFToDoRouter.h"
#import "YFToDoViewController.h"

@interface YFToDoBaseViewController ()

@end

@implementation YFToDoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *redBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 44)];
    [redBtn setTitle:@"Button" forState:UIControlStateNormal];
    [redBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    redBtn.titleLabel.textColor = [UIColor blackColor];
    redBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:redBtn];
}

- (void)buttonClick {
    YFToDoViewController *vc = [YFToDoRouter createModule];
    [self.navigationController pushViewController:vc animated:YES];
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
