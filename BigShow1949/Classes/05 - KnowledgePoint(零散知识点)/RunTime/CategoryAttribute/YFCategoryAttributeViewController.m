//
//  YFCategoryAttributeViewController.m
//  BigShow1949
//
//  Created by zhht01 on 16/4/14.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFCategoryAttributeViewController.h"

#import "YFPerson+addproty.m"
#import "UILabel+Associate.h"

@interface YFCategoryAttributeViewController ()

@end

@implementation YFCategoryAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    // 例子1 分类添加属性
    YFPerson *person = [[YFPerson alloc] init];
    person.name = @"大卫";
    person.addr = @"中关村大厦";
    NSLog(@"成功给分类添加属性 addr = %@", person.addr);
    
    [person run];
    
    // 例子2
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.flashColor = [UIColor blueColor];
    NSLog(@"flashColor = %@", label.flashColor);
    [self.view addSubview:label];
    
    
}


@end
