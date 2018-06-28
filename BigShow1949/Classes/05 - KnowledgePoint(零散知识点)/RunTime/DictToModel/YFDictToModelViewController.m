//
//  YFDictToModelViewController.m
//  BigShow1949
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFDictToModelViewController.h"
#import "Person.h"
#import "YFPerson.h"
@interface YFDictToModelViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation YFDictToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.dataArr = [NSMutableArray array];
    NSArray *dictArr = @[@{@"name" : @"Jack",
                           @"userId" : @"11111",
                           @"classes" : @{@"className" : @"Chinese", @"time" : @"2016_03"},
                           @"teachers" : @[@{@"teaName" : @"Lisa1", @"teaAge" : @"21"},
                                           @{@"teaName" : @"Lisa2", @"teaAge" : @"22"},
                                           @{@"teaName" : @"Lisa3", @"teaAge" : @"23"}]},
                         @{@"name" : @"Rose",
                           @"userId" : @"22222",
                           @"classes" : @{@"className" : @"Math", @"time" : @"2016_04"},
                           @"teachers" : @[@{@"teaName" : @"Lisa1", @"teaAge" : @"21"},
                                           @{@"teaName" : @"Lisa2", @"teaAge" : @"22"},
                                           @{@"teaName" : @"Lisa3", @"teaAge" : @"23"}]}];
    
    
    for (NSDictionary *dict in dictArr) {
        Person *p = [Person modelWithDict:dict];
        [self.dataArr addObject:p];
    }

    NSLog(@"dataArr = %@", self.dataArr);

    [self KVCtoModel];
    
    [self printValue];
    
}

// VC字典转模型
- (void)KVCtoModel {

    NSDictionary *dict = @{@"userName" : @"jack",
                           @"age" : @"12"};
    YFPerson *person = [YFPerson personWithDict:dict];
    NSLog(@"name = %@, age = %@", person.name, person.age);
}

// 打印字典属性
- (void)printValue {
    // 模型嵌套是打印不出来的
    NSDictionary *dict = @{@"name" : @"jack",
                           @"age" : @"12"};
    [Model resolveDict:dict];
}



@end
