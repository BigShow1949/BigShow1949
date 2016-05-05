//
//  UIImage+EXtension.h
//  BigShow1949
//
//  Created by zhht01 on 16/4/1.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EXtension)

/**
 *  根据颜色创建一个图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color;


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;  // 不能用


/**
 *  自由拉伸一张图片
 *
 *  注意: 默认从中间拉伸
 */
+ (UIImage *)stretchImageWithName:(NSString *)name;

/**
 *  自由拉伸一张图片
 *
 *  @param left : 左边不拉伸区域的宽度
 *  @param top : 上面不拉伸的高度
 *
 *  注意: 默认从中间拉伸
 */
+ (UIImage *)stretchImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  自由拉伸一张图片
 *
 *  @param scaleLeft : 值范围0-1 左边不拉伸区域的宽度 占图片宽度的比
 *  @param scaleTop  : 值范围0-1 上面不拉伸的高度 占图片高度的比
 *
 *  注意: 默认从中间拉伸
 */
+ (UIImage *)stretchImageWithName:(NSString *)name scaleLeft:(CGFloat)scaleLeft scaleTop:(CGFloat)scaleTop;

+ (UIImage *)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
+ (UIImage *)circleImageWithName:(NSString *)name;
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  返回一张圆形图片
 *
 *  @param scaleLeft : 值范围0-1 左边不拉伸区域的宽度 占图片宽度的比
 *  @param scaleTop  : 值范围0-1 上面不拉伸的高度 占图片高度的比
 *
 *  注意: 默认从中间拉伸
 */
+ (UIImage*)circleImage:(UIImage*)image withInset:(CGFloat)inset;



/*--------  另外一个文件 ----*/
/**
 *  传入一张图片,缩放到指定大小
 *
 *  @param img  传入的图片
 *  @param size 指定缩放到的尺寸
 *
 *  @return 返回指定大小的图片
 */
+(UIImage *)image:(UIImage *)img scaleToSize:(CGSize)size;
/**
 *  传入一张图片,缩放到指定比例
 *
 *  @param img   需要缩放的图片
 *  @param scale 缩放的比例
 *
 *  @return 返回指定缩放比例的图片
 */
+(UIImage *)image:(UIImage *)img scale:(CGFloat)scale;


/**
 *  使用imge 作为另一个 imge的 遮罩 返回遮罩后的img
 *
 *  @param image
 *  @param maskImage
 *
 *  @return
 */
+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;



@end
