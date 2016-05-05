//
//  UIImage+Extend.h
//  02-刷帧动画
//
//  Created by Apple on 15/5/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CZImageDirectionLeft, // 向左 0
    CZImageDirectionRight, // 向右 1
}CZImageDirection;

@interface UIImage (Extend)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
// 图片移动的方法
@property (nonatomic,assign) CZImageDirection direction;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com