//
//  SYTextView.m
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SYTextView.h"

@implementation SYTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 文字发生改变,就调用[self setNeedsDisplay],刷新界面,重新调用drawRect:(CGRect)rect
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UITextViewTextDidChangeNotification object:self];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// 别人可能改变占位文字属性, 这个时候没有重画, 是显示不出来的
- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    [self setNeedsDisplay];
}

// 别人可能改变字体, 这里需要重画一下
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];

}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    
    // 属性文字
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 画文字
    CGRect placehoderRect;
    placehoderRect.origin = CGPointMake(5, 7);
    CGFloat w = rect.size.width - 2 * placehoderRect.origin.x;
    CGFloat h = rect.size.height;
    placehoderRect.size = CGSizeMake(w, h);
    [self.placehoder drawInRect:placehoderRect withAttributes:dic];
    
}

@end
