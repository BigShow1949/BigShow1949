//
//  SYEmotionContentView.h
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYEmotionContentView : UIView
/**
 *  内部显示的表情数据(里面都是SYEmotion模型)
 */
@property (nonatomic, strong)NSArray *emotions;
@end
