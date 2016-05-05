//
//  LccDataCell.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/2.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LccDataCell : UITableViewCell

//自定义初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSArray * )pArray;

@end
