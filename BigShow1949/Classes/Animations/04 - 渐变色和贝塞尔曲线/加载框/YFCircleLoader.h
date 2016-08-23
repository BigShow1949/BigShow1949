//
//  YFCircleLoader.h
//  BigShow1949
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLoader : UIView

//进度颜色
@property(nonatomic, retain) UIColor* progressTintColor ;


//轨道颜色
@property(nonatomic, retain) UIColor* trackTintColor ;

//轨道宽度
@property (nonatomic,assign) float lineWidth;

//中间图片
@property (nonatomic,strong) UIImage *centerImage;

//进度
@property (nonatomic,assign) float progressValue;

//提示标题
@property (nonatomic,strong) NSString *promptTitle;

//开启动画
@property (nonatomic,assign) BOOL animationing;

//隐藏消失
- (void)hide;

@end
