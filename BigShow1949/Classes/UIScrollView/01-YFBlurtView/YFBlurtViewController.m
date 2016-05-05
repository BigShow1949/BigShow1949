//
//  YFBlurtViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/14.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFBlurtViewController.h"
#import "YFBlurtView.h"

@interface YFBlurtViewController ()

@end

@implementation YFBlurtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    YFBlurtView *b = [[YFBlurtView alloc] initWithFrame:self.view.frame WithHeaderImgHeight:170 iconHeight:100 selectBlock:^(NSIndexPath *indexPath) {
        NSLog(@"indexpath.row is %zi indexpath.section is %zi",indexPath.row,indexPath.section);
    }];
    [self.view addSubview:b];
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
