//
//  SYEmotionKeyboard.m
//  01 - 表情键盘
//
//  Created by apple on 15-1-30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SYEmotionKeyboard.h"
#import "SYEmotionContentView.h"
#import "SYEmotionTool.h"

static NSString * const SYDefaultText = @"默认";
static NSString * const SYLxhText = @"浪小花";
static NSString * const SYRecentText = @"最近";

// 目的:不想要高亮效果,又不想另外写个类,就写在一起
@interface SYEmotionToolbarButton : UIButton
@end
@implementation SYEmotionToolbarButton
- (void)setHighlighted:(BOOL)highlighted {}
@end

@interface SYEmotionKeyboard()
/** 底部的工具条 */
@property (nonatomic, weak)UIView *toolbar;
/** 当前被选中的按钮 */
@property (nonatomic, weak) SYEmotionToolbarButton *selectedButton;
/** 最近 */
@property (nonatomic, strong) SYEmotionContentView *recentContentView;
/** 默认 */
@property (nonatomic, strong) SYEmotionContentView *defaultContentView;
/** 浪小花 */
@property (nonatomic, strong) SYEmotionContentView *lxhContentView;

/** 当前被选中的内容(正在显示) */
@property (nonatomic, weak) SYEmotionContentView *selectedContentView;
@end


@implementation SYEmotionKeyboard

- (SYEmotionContentView *)recentContentView
{
    if (!_recentContentView) {
        self.recentContentView = [[SYEmotionContentView alloc] init];
        self.recentContentView.emotions = [SYEmotionTool recentEmotions];
    }
    return _recentContentView;
}

- (SYEmotionContentView *)defaultContentView
{
    if (!_defaultContentView) {
        self.defaultContentView = [[SYEmotionContentView alloc] init];
        self.defaultContentView.emotions = [SYEmotionTool defaultEmotions];
    }
    return _defaultContentView;
}

- (SYEmotionContentView *)lxhContentView
{
    if (!_lxhContentView) {
        self.lxhContentView = [[SYEmotionContentView alloc] init];
        self.lxhContentView.emotions = [SYEmotionTool lxhEmotions];
    }
    return _lxhContentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        
        // 1.创建底部工具条
        UIView *toolbar = [[UIView alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 2.创建底部工具条的按钮
        [self setupButton:SYRecentText];
        [self buttonClick:[self setupButton:SYDefaultText]];
        [self setupButton:SYLxhText];
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (SYEmotionToolbarButton *)setupButton:(NSString *)title
{
    SYEmotionToolbarButton *button = [[SYEmotionToolbarButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.toolbar addSubview:button];
    
    return button;
}

- (void)buttonClick:(SYEmotionToolbarButton *)button
{
    // 设置按钮的状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 移除当前正在显示的内容
    [self.selectedContentView removeFromSuperview];
    
    // 切换顶部的内容
    if ([button.currentTitle isEqualToString:SYDefaultText]) {
        [self addSubview:self.defaultContentView];
        self.selectedContentView = self.defaultContentView;
    } else if ([button.currentTitle isEqualToString:SYLxhText]) {
        [self addSubview:self.lxhContentView];
        self.selectedContentView = self.lxhContentView;
    } else if ([button.currentTitle isEqualToString:SYRecentText]) {
        [self addSubview:self.recentContentView];
        self.selectedContentView = self.recentContentView;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.底部的工具条
    self.toolbar.x = 0;
    self.toolbar.height = 35;
    self.toolbar.width = self.width;
    self.toolbar.y = self.height - self.toolbar.height;
    
    // 2.底部工具条的按钮
    NSUInteger count = self.toolbar.subviews.count;
    CGFloat buttonW = self.toolbar.width / count;
    for (NSUInteger i = 0; i < count; i++) {
        SYEmotionToolbarButton *button = self.toolbar.subviews[i];
        button.y = 0;
        button.height = self.toolbar.height;
        button.width = buttonW;
        button.x = i * buttonW;
    }
    
    // 3.设置尺寸
    self.selectedContentView.width = self.width;
    self.selectedContentView.height = self.toolbar.y;
    
}

@end
