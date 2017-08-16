//
//  YFLabel.h
//  2048
//
//  Created by apple on 15-6-21.
//  Copyright (c) 2015年 杨帆_company. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YFColor_chess_2 YFColor(235, 223, 221)
#define YFColor_chess_4 YFColor(230, 215, 190)
#define YFColor_chess_8 YFColor(240, 160, 105)
#define YFColor_chess_16 YFColor(15, 206, 92)
#define YFColor_chess_32 YFColor(246, 124, 95)
#define YFColor_chess_64 YFColor(237, 207, 114)
#define YFColor_chess_128 YFColor(246, 94, 59)
#define YFColor_chess_256 YFColor(109, 158, 235)
#define YFColor_chess_512 YFColor(241, 194, 50)
#define YFColor_chess_1024 YFColor(255, 0, 255)
#define YFColor_chess_2048 YFColor(255, 0, 0)

// 棋子之间的间隙
#define YFPadding_chess 8
// 棋子(背景)的宽高
#define YFChessWH (YFScreen.width - 5 * YFPadding_chess) / 4

@interface YFLabel : UILabel

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int line;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) BOOL isLabelMoving;

/**
 *  手指扫一次,每个按钮都只能加一次
 */
@property (nonatomic, assign) BOOL canAdd;

/**
 *  label移动到row行 line列
 */
- (void)moveHereWithRow:(int)row line:(int)line;

@end
