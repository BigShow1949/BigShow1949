//
//  UILabel+Associate.h
//  BigShow1949
//
//  Created by zhht01 on 16/4/15.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

@interface UILabel (Associate)

- (void)setFlashColor:(UIColor *)flashColor;

- (UIColor *)flashColor;

@end
