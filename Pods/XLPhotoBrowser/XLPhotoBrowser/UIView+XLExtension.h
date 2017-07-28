//
//  UIView+Extension.h
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//  QmangoHotel
//
//  Created by Xiaol on 16/3/25.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XLExtension)
@property (assign, nonatomic) CGFloat xl_x;
@property (assign, nonatomic) CGFloat xl_y;
@property (assign, nonatomic) CGFloat xl_width;
@property (assign, nonatomic) CGFloat xl_height;
@property (assign, nonatomic) CGSize xl_size;
@property (assign, nonatomic) CGPoint xl_origin;

@property (assign, nonatomic) CGFloat xl_centerX;
@property (assign, nonatomic) CGFloat xl_centerY;

-(CGRect)coordinateInWindowView:(UIView*)superView;
@end
