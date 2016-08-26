//
//  YFAnswerNaviBar.h
//  AnswerQuestions
//
//  Created by zhht01 on 16/3/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFAnswerNaviBarDelegate <NSObject>

@required
- (void)backButtonClick;

@end

@interface YFAnswerNaviBar : UIView
@property (nonatomic, assign) id<YFAnswerNaviBarDelegate> delegate;
@end
