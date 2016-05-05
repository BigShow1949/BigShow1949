//
//  YFRecordData.h
//  2048
//
//  Created by apple on 15-6-28.
//  Copyright (c) 2015年 杨帆_company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFRecordData : NSObject

@property (nonatomic, strong) NSMutableArray *chesses; // 存放当前棋盘中所有棋子(存放类型:UILabel)
@property (nonatomic, assign) int nowScore;
@property (nonatomic, assign) int maxScore;

- (YFRecordData *)initWithNowScore:(int)nowScore maxScore:(int)maxScore array:(NSMutableArray *)chesses;

@end
