//
//  YFAnswerBox.m
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFAnswerBox.h"

@implementation YFAnswerBox

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame:) name:@"changeFrame" object:nil];
        [self makeView:frame];
    }
    return self;
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeFrame" object:nil];
    
}

- (void)makeView:(CGRect)frame {

    self.frame = frame;
    self.contentSize = CGSizeMake(0, 800);
    self.backgroundColor = [UIColor whiteColor];


//    UIButton *dragBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    dragBtn.center = CGPointMake(frame.size.width * 0.5, 10);
//    [dragBtn setImage:[UIImage imageNamed:@"dragBtn"] forState:UIControlStateNormal];
//    [self addSubview:dragBtn];

}

#pragma mark - YFDragButtonDelegate
- (void)changeSelfFrame:(CGFloat)y {

    CGRect tempF = self.frame;
    tempF = CGRectMake(tempF.origin.x, tempF.origin.y + y, tempF.size.width, tempF.size.height - y);
    self.frame = tempF;

}

- (void)changeFrame:(NSNotification *)noti {

    CGFloat y = [noti.object floatValue];
    CGRect tempF = self.frame;
    tempF = CGRectMake(tempF.origin.x, tempF.origin.y + y, tempF.size.width, tempF.size.height - y);
    self.frame = tempF;
    
}

@end
