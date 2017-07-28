//
//  XLPhotoBrowserController.h
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//  
//
//  Created by xiaoL on 16/11/29.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPhotoBrowserDelegate.h"

@interface XLPhotoBrowserController : UIViewController
@property (nonatomic,weak) id<XLPhotoBrowserTapDelegate> delegate;
-(void)setupUIWithCurrentImgAdapter:(id<XLPhotoBrowserAdapterDelegate>)imgAdapter imageAdaptersBank:(NSArray<id<XLPhotoBrowserAdapterDelegate>> *)imageAdaptersBank;
@end
