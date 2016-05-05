//
//  SYTabBar.m
//  31.3 - 主流框架
//
//  Created by apple on 15-3-6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SYTabBar.h"
#import "SYTabButton.h"

@interface SYTabBar ()
@property (nonatomic, assign) UIButton *selectButton;
@end

@implementation SYTabBar

+ (instancetype)tabBar
{
    SYTabBar *tabBar = [[SYTabBar alloc] init];
    return tabBar;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    UIButton *button = [SYTabButton buttonWithType:UIButtonTypeCustom];
    button.tag = self.subviews.count;
    
    [button setBackgroundImage:item.image forState:UIControlStateNormal];
    [button setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
    
    if (self.subviews.count) {
        [self btnClick:button];
    }
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];

    [self addSubview:button];
}

// 监听按钮点击
- (void)btnClick:(UIButton *)button
{
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
//    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
//        [_delegate tabBar:self didSelectIndex:button.tag];
//    }

    if (_tabBarBlock) {
        _tabBarBlock(button.tag);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnW = self.bounds.size.width / count;
        CGFloat btnH = self.bounds.size.height;
        CGFloat btnX = i * btnW;
        
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
    }
}









@end
