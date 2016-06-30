//
//  OneTableViewCell.m
//  BigShow1949
//
//  Created by 杨帆 on 16/6/30.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "OneTableViewCell.h"
#import "ModelOne.h"
@implementation OneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configCellWithEntity:(id)entity
{
    if(entity)
    {
        ModelOne *model = entity;
        self.textLabel.text = model.name;
    }
}

@end
