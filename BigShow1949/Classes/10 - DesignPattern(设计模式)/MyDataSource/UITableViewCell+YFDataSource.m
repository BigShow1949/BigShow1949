//
//  UITableViewCell+YFDataSource.m
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "UITableViewCell+YFDataSource.h"

@implementation UITableViewCell (YFDataSource)


+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)configCellWithEntity:(id)entity
{
    
}

@end
