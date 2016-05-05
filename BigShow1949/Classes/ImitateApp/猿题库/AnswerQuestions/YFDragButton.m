//
//  YFDragButton.m
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFDragButton.h"

@implementation YFDragButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFrame:) name:@"changeFrame" object:nil];
    }
    return self;
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeFrame" object:nil];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSLog(@"self.frame.origin.y = %f", self.frame.origin.y);
    if (self.frame.origin.y < 80 && point.y < 0) {  // 上限     // BUG: 猛的上滑,越过了
        return;
    }
    
    if (self.frame.origin.y > self.superview.frame.size.height - self.frame.size.height - 20 && point.y > 0) {  // 下限
        return;
    }
    

    NSString *str = [NSString stringWithFormat:@"%f", point.y];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeFrame" object:str];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan---------button");
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {  
    NSLog(@"touchesEnded---------button");
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded---------button");
    
}

- (void)changeFrame:(NSNotification *)noti {
    
    CGFloat y = [noti.object floatValue];
    
    CGRect btnF = self.frame;
    CGFloat newY = btnF.origin.y + y;
//    if (newY < 80) {  // 上限
//        newY = 80;
//    }
//    
//    if (newY > self.superview.frame.size.height - self.frame.size.height - 20) {  // 上限
//        newY = self.superview.frame.size.height - self.frame.size.height - 20;
//    }

    btnF = CGRectMake(btnF.origin.x, newY, btnF.size.width, btnF.size.height);
    self.frame = btnF;
    
    
}
@end
