//
//  LccCell.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/1.
//  Copyright © 2015年 LccLcc. All rights reserved.
//


#import "Define.h"
#import "LccCell.h"

@implementation LccCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)width{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(35, 5, width - 70, 34)];
        self.textFiled.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.textFiled];
    }
    
    return self;
    
}
@end
