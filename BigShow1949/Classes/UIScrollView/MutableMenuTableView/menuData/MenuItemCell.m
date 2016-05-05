//
//  MenuItemCell.m
//  MutableMenuTableView
//
//  Created by 张国庆 on 16/4/27.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import "MenuItemCell.h"

@implementation MenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLevel:(NSInteger)level
{
    if(self.item)
    {
        self.label.text=self.item.title;
        if([self.item.subItems count]>0)
        {
            self.detailLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)[self.item.subItems count]];
            self.detailLabel.textColor=[UIColor blueColor];
        }
        else
        {
            self.detailLabel.text=@"-";
            self.detailLabel.textColor=[UIColor grayColor];
        }
    }
    CGRect labelRec=self.label.frame;
    labelRec.origin.x=20*level+10;
    self.label.frame=labelRec;
}

@end
