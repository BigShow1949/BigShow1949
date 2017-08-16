//
//  LccButton.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/2.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "LccButton.h"

@implementation LccButton



+(instancetype)buttonWithType:(UIButtonType)type{

    LccButton * btn = [super buttonWithType:type];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, 45, 25);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor grayColor].CGColor;

    return btn;
    
}  

@end
