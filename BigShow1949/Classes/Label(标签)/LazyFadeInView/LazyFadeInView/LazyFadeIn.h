//
//  LazyFadeIn.h
//  LazyFadeInView
//
//  Created by Tu You on 14-4-21.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LazyFadeIn <NSObject>

//! @abstract The duration of the complete fading. Defaults to 1.0.
@property (assign, nonatomic, readwrite) CFTimeInterval duration;

//! @abstract The number of layers lazy loading. Defaults to 3.
@property (assign, nonatomic, readwrite) NSUInteger numberOfLayers;

//! @abstract The interval of layers fading. Defaults to 0.2
@property (assign, nonatomic, readwrite) CFTimeInterval interval;

@end

