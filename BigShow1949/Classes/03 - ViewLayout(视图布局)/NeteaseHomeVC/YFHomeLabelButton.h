//
//  YFHomeLabelButton.h
//  BigShow1949
//
//  Created by zhht01 on 16/1/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFHomeLabelButton : UIButton
/**
 *  传入一个百分值来调整按钮内部的细节
 *
 *  @param percent 按钮占据的百分比
 */
- (void)adjust:(CGFloat)percent;
@end
