//
//  SecondTableViewCell.m
//  test
//
//  Created by 杨帆 on 16/6/29.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "ModelTwo.h"
@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    NSLog(@"dfasdfasdf");
}

- (void)configCellWithEntity:(id)entity
{
    if(entity)
    {
        ModelTwo *model = entity;
        self.textLabel.text = model.name;
    }
}

@end
