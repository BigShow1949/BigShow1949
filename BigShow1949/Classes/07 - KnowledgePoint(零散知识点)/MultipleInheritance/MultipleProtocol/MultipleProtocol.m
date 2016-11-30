//
//  MultipleProtocol.m
//  BigShow1949
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MultipleProtocol.h"
#import "Dog_MP.h"
@interface MultipleProtocol ()

@end

@implementation MultipleProtocol

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 多继承 协议
    Dog_MP *dog = [[Dog_MP alloc] init];
    [dog swim];
    /*
     1、通过协议实现的多继承,只提供了接口,没有提供实现方式,不能调用父类的方法.所以,如果只是想多继承基类的接口，那么遵守多协议无疑是最好的方法，而既需要多继承接口，又要多继承其实现，那么协议是无能为力了。
     比如:这里Dog调用Fish的swim方法,相当于重写了swim方法,Dog是不知道Fish怎么实现swim方法的,甚至Fish根本就没有实现swim方法.
     */
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
