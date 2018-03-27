//
//  UIButton+touch.h
//  LiqForDoctors
//
//  Created by StriEver on 16/3/10.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval .5  //默认时间间隔
@interface UIButton (touch)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
@end

