//
//  DynamicItem.h
//  Demo
//
//  Created by weijingyun on 16/12/3.
//  Copyright © 2016年 weijingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicItem : NSObject<UIDynamicItem>

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign, readonly) CGRect bounds;
@property (nonatomic, assign) CGAffineTransform transform;

@end
