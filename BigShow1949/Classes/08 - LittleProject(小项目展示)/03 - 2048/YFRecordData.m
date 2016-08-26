//
//  YFRecordData.m
//  2048
//
//  Created by apple on 15-6-28.
//  Copyright (c) 2015年 杨帆_company. All rights reserved.
//

#import "YFRecordData.h"

#import "YFLabel.h"

@implementation YFRecordData


- (YFRecordData *)initWithNowScore:(int)nowScore maxScore:(int)maxScore array:(NSMutableArray *)chesses{
    
    self.nowScore = nowScore;
    self.maxScore = maxScore;
    self.chesses = [NSMutableArray arrayWithArray:(NSArray *)chesses];
    
    return self;

}


@end
