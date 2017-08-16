//
//  YFChessBoardView.h
//  Jigsaw
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一定是个正方形
@interface YFChessBoardView : UIImageView

@property (nonatomic, strong) UIImage *backgroundImage;

- (void)randomBreak;

@end
