//
//  UITableViewCell+YFDataSource.h
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (YFDataSource)

/**
 *  返回nib
 *
 *  @return 返回nib
 */
+ (UINib *)nib;


/**
 *  根据实体,设置cell样式
 *
 *  @param entity 实体
 */
- (void)configCellWithEntity:(id)entity;

@end
