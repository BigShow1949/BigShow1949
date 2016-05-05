//
//  YFAnswerNaviBar.m
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAnswerNaviBar.h"

@implementation YFAnswerNaviBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, YFScreen.width, 64);
        self.backgroundColor = [UIColor darkGrayColor];
        
        [self makeView];
    }
    return self;
}

- (void)makeView {

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
//    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
}
- (void)backButtonClick {

    [self.delegate backButtonClick];
}

@end
