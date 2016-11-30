//
//  MultipleMsgForawrd.m
//  BigShow1949
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "MultipleMsgForawrd.h"
#import "Teacher_MMF.h"
#import "Lawyer_MMF.h"
#import "Doctor_MMF.h"

@interface MultipleMsgForawrd ()

@end

@implementation MultipleMsgForawrd

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    // 多继承 消息转发
    Teacher_MMF *teacher = [[Teacher_MMF alloc] init];
    [teacher performSelector:@selector(operate)];
    //    [teacher performSelector:@selector(speak)];
    // 虽然消息可以动态发,但是编译不过,可以用以下方法
    // 这里的分类只是声明下,不然得动态调用.但是,此方法是在.h里写死的,如果Doctor的方法改为operate2,这里teacher还是operate,没有更换,所以用下面的方法
    //    [teacher operate];
    // 相对方法1灵活,而且隐藏了我要转发的消息
    //    [(Doctor *)teacher operate];
    
    // 问题:如果转成id类型,也能编译通过并转发,但问题是不清楚具体调用谁的方法实现的.
    // 如果Lawyer也实现了operate2方法,并且是想teacher继承Lawyer的operate2方法,但实际是调用的Doctor的operate2方法
    //    [(id)teacher operate2];
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
