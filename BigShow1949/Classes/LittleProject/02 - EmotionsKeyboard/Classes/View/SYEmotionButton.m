//
//  SYEmotionButton.m
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SYEmotionButton.h"
#import "SYEmotion.h"

@implementation SYEmotionButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 只对image有效, 对background没有效果, 如果要取消background的高亮,重写setHighlighted:
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(SYEmotion *)emotion
{
    _emotion = emotion;
    
    NSString *name = [NSString stringWithFormat:@"%@/%@", emotion.folder, emotion.png];
    [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

@end
