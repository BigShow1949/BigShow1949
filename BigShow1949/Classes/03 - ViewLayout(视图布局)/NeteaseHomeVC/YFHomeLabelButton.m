//
//  YFHomeLabelButton.m
//  BigShow1949
//
//  Created by zhht01 on 16/1/22.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "YFHomeLabelButton.h"

static const CGFloat NormalSize = 11.0f;
static const CGFloat SelectSize = 20.0f;

#define NormalFont [UIFont systemFontOfSize:NormalSize]
#define SelectedFont [UIFont systemFontOfSize:SelectSize]

static const int NormalRed = 0;
static const int NormalGreen = 0;
static const int NormalBlue = 0;

static const int SelectedRed = 255;
static const int SelectedGreen = 0;
static const int SelectedBlue = 0;

#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface YFHomeLabelButton()
@property (nonatomic, assign) int red;
@property (nonatomic, assign) int green;
@property (nonatomic, assign) int blue;
@end

@implementation YFHomeLabelButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.red = NormalRed;
        self.green = NormalGreen;
        self.blue = NormalBlue;
        
        [self setTitleColor:Color(NormalRed, NormalGreen, NormalBlue) forState:UIControlStateNormal];
        self.titleLabel.font = NormalFont;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    self.titleLabel.font = selected ? SelectedFont : NormalFont;
    
    if (selected) {
        self.red = SelectedRed;
        self.green = SelectedGreen;
        self.blue = SelectedBlue;
    } else {
        self.red = NormalRed;
        self.green = NormalGreen;
        self.blue = NormalBlue;
    }
    
    [self setTitleColor:Color(self.red, self.green, self.blue) forState:UIControlStateSelected];
}

- (void)adjust:(CGFloat)percent
{
    // 调整文字大小
    CGFloat size = NormalSize + (SelectSize - NormalSize) * percent;
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    
    // 调整颜色
    self.red = NormalRed + (SelectedRed - NormalRed) * percent;
    self.green = NormalGreen + (SelectedGreen - NormalGreen) * percent;
    self.blue = NormalBlue + (SelectedBlue - NormalBlue) * percent;
    [self setTitleColor:Color(self.red, self.green, self.blue) forState:UIControlStateNormal];
    [self setTitleColor:Color(self.red, self.green, self.blue) forState:UIControlStateSelected];
}

@end
