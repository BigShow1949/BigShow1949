//
//  YFResizableView.h
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFQuestionBox.h"
#import "YFAnswerBox.h"
#import "YFDragButton.h"

@interface YFResizableView : UIScrollView

@property (nonatomic, strong) YFQuestionBox *questionBox;
@property (nonatomic, strong) YFAnswerBox *answerBox;
@property (nonatomic, strong) YFDragButton *dragButton;

@end
