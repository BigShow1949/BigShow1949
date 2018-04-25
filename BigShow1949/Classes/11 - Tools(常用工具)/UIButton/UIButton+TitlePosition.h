//
//  UIButton+TitlePosition.h
//  test
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 BigShow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YFTitleStyle) {
    YFTitleStyleTitleOnly = 1, //只显示文字
    YFTitleStyleImgOnly,      //只显示图片
    YFTitleStyleLeft,     //文字在左，图片在右
    YFTitleStyleRight,    //文字在右，图片在左
    YFTitleStyleTop,      //文字在上，图片在下
    YFTitleStyleBottom    //文字在下，图片在上
};

@interface UIButton (TitlePosition)

//调用这个方法前，必须先设置好button的image和title/attributedtitle 要不然无法生效
- (void)layoutTitleWithStyle:(YFTitleStyle)style imageTitleSpace:(CGFloat)space;
@end
