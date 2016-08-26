//
//  WSFSlideTitlesView.h
//  WSFSlideTitlesView
//
//  Created by WangShengFeng on 3/7/16.
//  Copyright © 2016 WangShengFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSFSlideTitlesView;
@class WSFSlideTitlesViewSetting;

@protocol WSFSlideTitlesViewDelegate <NSObject>

@optional

// 通知外部选中按钮更换
- (void)slideTitlesView:(WSFSlideTitlesView *)titlesView didSelectButton:(UIButton *)button atIndex:(NSUInteger)index;

@end

@interface WSFSlideTitlesView : UIView

@property (nonatomic, weak) id<WSFSlideTitlesViewDelegate> delegate;

// 两种创建方法
+ (instancetype)slideTitlesViewWithSetting:(WSFSlideTitlesViewSetting *)setting;
- (instancetype)initWithSetting:(WSFSlideTitlesViewSetting *)setting;

// 外部修改选中按钮
- (void)selectButtonAtIndex:(NSUInteger)index;

@end

@interface WSFSlideTitlesViewSetting : NSObject

#pragma mark 标题设置
// 普通状态按钮标题
@property (nonatomic, strong) NSArray *titlesArr;
// 选中状态按钮标题，默认与普通状态一样
@property (nonatomic, strong) NSArray *selectedTitlesArr;
// 整个 view 的尺寸
@property (nonatomic, assign) CGRect frame;
// 整个 view 的背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;
// 普通状态标题颜色，默认为黑色
@property (nonatomic, strong) UIColor *textColor;
// 选中状态标题颜色，默认为橙色
@property (nonatomic, strong) UIColor *selectedTextColor;
// 普通状态字体大小，默认为系统大小
@property (nonatomic, assign) CGFloat textFontSize;
// 选中状态字体大小，默认与普通状态一样
@property (nonatomic, assign) CGFloat selectedTextFontSize;

#pragma mark 横线设置
// 隐藏状态，默认为不隐藏
@property (nonatomic, assign) BOOL lineHidden;
// 横线宽度，默认为与标题文字同宽
@property (nonatomic, assign) CGFloat lineWidth;
// 横线高度，默认为 1
@property (nonatomic, assign) CGFloat lineHeight;
// 横线颜色，默认为与选中状态标题颜色一样
@property (nonatomic, strong) UIColor *lineColor;
// 横线与底部距离，默认为 1
@property (nonatomic, assign) CGFloat lineBottomSpace;
// 横线动画时间，默认为 0.5 妙
@property (nonatomic, assign) NSTimeInterval animateDuration;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com