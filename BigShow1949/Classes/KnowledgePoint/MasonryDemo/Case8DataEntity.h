//
// Created by zorro on 15/12/5.
// Copyright (c) 2015 tutuge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Case8DataEntity : NSObject
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) BOOL expanded; // 是否已经展开
// Cache
@property (assign, nonatomic) CGFloat cellHeight;
@end