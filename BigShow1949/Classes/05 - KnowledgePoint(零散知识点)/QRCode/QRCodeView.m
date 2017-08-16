//
//  QRCodeGenerateView.m
//  TestQR
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "QRCodeView.h"

@implementation QRCodeView

#pragma mark - public
- (QRCodeView *)initWithFrame:(CGRect)frame urlString:(NSString *)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1、创建滤镜对象
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
        // 恢复滤镜的默认属性
        [filter setDefaults];
    
        // 2、设置数据
        NSString *info = urlString;
        NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    
        // 通过KVC设置滤镜inputMessage数据
        [filter setValue:infoData forKeyPath:@"inputMessage"];
    
        // 3、获得滤镜输出的图像
        CIImage *outputImage = [filter outputImage];

        // 4、将CIImage转换成UIImage
        self.image = [self createNonInterpolatedUIImageFormCIImage:outputImage size:self.frame.size.width];
        
        return self;
    }
    return self;
}


- (void)setCenterImg:(UIImage *)centerImg {

    _centerImg = centerImg;
    
    UIImageView *centerImgView = [[UIImageView alloc] init];
    centerImgView.image = centerImg;
    CGFloat icon_imageW = 20;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (self.frame.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (self.frame.size.height - icon_imageH) * 0.5;
    centerImgView.frame = CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH);
    [self addSubview:centerImgView];
}

- (void)setColor:(UIColor *)color {
    
    _color = color;
    
    NSArray *colorArr = [self getRGBWithColor:color];
    CGFloat red   = [colorArr[0] floatValue];
    CGFloat green = [colorArr[1] floatValue];
    CGFloat blue  = [colorArr[2] floatValue];
    
    self.image = [self imageBlackToTransparent:self.image withRed:red andGreen:green andBlue:blue];
}

#pragma mark - private
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

// 生成高清图片
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
//    UIImage *newImage = [UIImage imageWithCGImage:scaledImage];
//    return [self imageBlackToTransparent:newImage withRed:200.0f andGreen:200.0f andBlue:200.0f];
}


- (NSArray *)getRGBWithColor:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

- (NSMutableArray *)changeUIColorToRGB:(UIColor *)color
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@", color];
    
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    
    //获取红色值
    float r = [RGBArr[1] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", r];
    [RGBStrValueArr addObject:RGBStr];
    
    //获取绿色值
    float g = [RGBArr[2] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", g];
    [RGBStrValueArr addObject:RGBStr];
    
    //获取蓝色值
    float b = [RGBArr[3] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", b];
    [RGBStrValueArr addObject:RGBStr];
    
    float a = [RGBArr[4] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", a];
    [RGBStrValueArr addObject:RGBStr];
    
    //返回保存RGB值的数组
    return RGBStrValueArr;
}
@end
