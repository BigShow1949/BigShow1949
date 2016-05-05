//
//  YFResizableView.m
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFResizableView.h"


#define questCount 5

@implementation YFResizableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentSize = CGSizeMake(5 * frame.size.width, 0);
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        [self makeView:frame];
    }
    return self;
}

- (void)makeView:(CGRect)frame {

    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    for (int i = 0; i< questCount; i++) {
        
        // questionBox
        YFQuestionBox *questionBox = [[YFQuestionBox alloc] initWithFrame:CGRectMake(i * w, 0, w, h * 0.5)];
        [self addSubview:questionBox];
        self.questionBox = questionBox;
        
        // answerBox
        YFAnswerBox *answerBox = [[YFAnswerBox alloc] initWithFrame:CGRectMake(i * w, h * 0.5, w, h * 0.5)];
        [self addSubview:answerBox];
        self.answerBox = answerBox;
        
        // dragButton
        CGFloat dragW = 70;
        CGFloat dragH = 20;
        CGFloat dragX = (w - dragW) * 0.5 + i * w;
        CGFloat dragY = CGRectGetMinY(answerBox.frame) - dragH;
        YFDragButton *dragButton = [[YFDragButton alloc] initWithFrame:CGRectMake(dragX, dragY, dragW, dragH)];
        [dragButton setBackgroundImage:[UIImage imageNamed:@"dragBtn"] forState:UIControlStateNormal];
        [dragButton setBackgroundImage:[UIImage imageNamed:@"dragBtn"] forState:UIControlStateHighlighted];
        [self addSubview:dragButton];
        self.dragButton = dragButton;
        
    }

}
@end
