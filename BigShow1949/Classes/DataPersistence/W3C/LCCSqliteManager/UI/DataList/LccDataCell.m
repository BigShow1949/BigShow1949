//
//  LccDataCell.m
//  DatabaseMangerDemo
//
//  Created by LccLcc on 15/12/2.
//  Copyright © 2015年 LccLcc. All rights reserved.
//

#import "Define.h"
#import "LccDataCell.h"
#import "LCCSqliteManager.h"
@implementation LccDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSArray *)pArray{
    
    NSLog(@"init新cell");
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithWhite:.9 alpha:.5];
        long width = KWidth/pArray.count;
        for (int i = 0; i < pArray.count; i ++) {
            UILabel *attributetitle = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 2, width, 40)];
            //标记，用于后续的提取
            attributetitle.tag = i+100;
            attributetitle.text = pArray[i];
            [attributetitle setFont:[UIFont systemFontOfSize:14]];
            attributetitle.textColor = [UIColor lightGrayColor];
            attributetitle.textAlignment = NSTextAlignmentCenter;
            [self addSubview:attributetitle];
        }

    
    }
    
    return self;
    
}


@end
