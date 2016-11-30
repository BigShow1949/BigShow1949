//
//  MultipleCombination.m
//  BigShow1949
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MultipleCombination.h"
#import "ClassA.h"
#import "ClassB.h"
#import "ClassC.h"

@interface MultipleCombination ()

@end

@implementation MultipleCombination

- (void)viewDidLoad {
    [super viewDidLoad];

    // 多继承 组合模式
    ClassA *a = [[ClassA alloc] init];
    ClassB *b = [[ClassB alloc] init];
    ClassC *c = [[ClassC alloc] initWithA:a b:b];
    [c methodA];
    /*
     1、组合实现下,想要继承来的不管是属性还是方法都没有提示.所以最好copy过来
     2、如果继承来的两个类中属性名和方法名相同就很麻烦了,要仔细区分开.比如:ClassA跟ClassB都有methodD方法,但看ClassC.h不知道继承的是A的还是B,只有看ClassC.m方法实现methodD中调用的哪个
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
