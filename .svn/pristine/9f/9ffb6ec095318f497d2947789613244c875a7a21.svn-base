//
//  XRPopMenuView.h
//  MatchBox
//  带动画效果弹出式全屏半透明背景view
//  Created by XiRuo on 15/7/22.
//  Copyright (c) 2015年 XiRuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XRPopMenuViewSelectedBlock)(void);

@interface XRPopMenuView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, readonly)UIImageView *backgroundImgView;
/**
 *  初始化后添加按钮
 */
- (void)addMenuItemWithTitle:(NSString*)title andIcon:(UIImage*)icon andSelectedBlock:(XRPopMenuViewSelectedBlock)block;

/**
 *  显示弹出框
 */
- (void)show;

@end