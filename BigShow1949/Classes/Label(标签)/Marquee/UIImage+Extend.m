//
//  UIImage+Extend.m
//  02-刷帧动画
//
//  Created by Apple on 15/5/27.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIImage+Extend.h"
#import <objc/runtime.h>
@implementation UIImage (Extend)

static char imageX;
static char imageY;
static char directions;
- (void)setX:(CGFloat)x {
    // 使用objc_setAssociatedObject函数能够为分类添加属性
    objc_setAssociatedObject(self, &imageX, [NSString stringWithFormat:@"%f",x], OBJC_ASSOCIATION_COPY);
}

- (CGFloat)x {
    return [objc_getAssociatedObject(self, &imageX) floatValue];
}

- (void)setY:(CGFloat)y {
    // 使用objc_setAssociatedObject函数能够为分类添加属性
    objc_setAssociatedObject(self, &imageY, [NSString stringWithFormat:@"%f",y], OBJC_ASSOCIATION_COPY);
}

- (CGFloat)y {
    return [objc_getAssociatedObject(self, &imageY) floatValue];
}

- (void)setDirection:(CZImageDirection)direction {
    // 使用objc_setAssociatedObject函数能够为分类添加属性
    objc_setAssociatedObject(self, &directions, [NSString stringWithFormat:@"%d",direction], OBJC_ASSOCIATION_COPY);
}

- (CZImageDirection)direction {
    return [objc_getAssociatedObject(self, &directions) boolValue];
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com