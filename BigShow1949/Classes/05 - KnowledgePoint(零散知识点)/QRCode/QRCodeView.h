//
//  QRCodeGenerateView.h
//  TestQR
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UIImageView


/**
 初始化二维码

 @param frame     二维码大小
 @param urlString 跳转链接

 @return 返回一个二维码
 */
- (QRCodeView *)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

/**
 二维码中间的图片
 */
@property (nonatomic, strong) UIImage *centerImg;


/**
 二维码颜色
 */
@property (nonatomic, strong) UIColor *color;



@end
