//
//  XLZoomableScrollView.h
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//  
//
//  Created by xiaoL on 16/11/29.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPhotoBrowserDelegate.h"

@interface XLZoomableScrollView : UIScrollView
@property (nonatomic,weak) id<XLPhotoBrowserTapDelegate> browserDelegate;
-(void)setupImageUrl:(NSString *)imgUrl placeholderImg:(UIImage *)placeholderImg;

@end
