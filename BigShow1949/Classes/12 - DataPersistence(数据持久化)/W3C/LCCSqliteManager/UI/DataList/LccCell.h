//
//  LccCell.h
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/1.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LccCell : UITableViewCell

@property(nonatomic,strong)UITextField *textFiled;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)width;
@end
