//
//  QRCodeGenerateView.m
//  TestQR
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "QRCodeView.h"
#import "CIImage+SGExtension.h"

@implementation QRCodeView

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
        self.image = [outputImage SG_createNonInterpolatedWithSize:self.frame.size.width];
    
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
@end
