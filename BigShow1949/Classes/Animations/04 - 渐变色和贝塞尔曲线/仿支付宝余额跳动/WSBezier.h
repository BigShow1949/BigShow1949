//
//  WSBezier.h
//  Test
//
//  Created by senro wang on 15/8/11.
//  Copyright (c) 2015年 王燊. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct
{
    float x;
    float y;
} WSPoint;


@interface WSBezier : NSObject

@property (nonatomic,assign) WSPoint wsStart;
@property (nonatomic,assign) WSPoint wsFirst;
@property (nonatomic,assign) WSPoint wsSecond;
@property (nonatomic,assign) WSPoint wsEnd;


- (WSPoint )pointWithdt:(float )dt;


@end
