//
//  YFAddMethodViewController.m
//  BigShow1949
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAddMethodViewController.h"
#import "YFPerson.h"

@interface YFAddMethodViewController ()

@end

@implementation YFAddMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     如果一个类方法非常多,加载了到内存的时候也比较耗费资源,需给每个方法生成映射表,可以使用动态给某个类,添加方法解决.
     */

    YFPerson *p = [[YFPerson alloc] init];
    
    // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
    [p performSelector:@selector(eat)];
}

@end
