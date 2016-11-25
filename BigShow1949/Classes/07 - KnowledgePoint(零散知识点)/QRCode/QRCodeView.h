//
//  QRCodeGenerateView.h
//  TestQR
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UIImageView

- (QRCodeView *)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

@property (nonatomic, strong) UIImage *centerImg;


@end
