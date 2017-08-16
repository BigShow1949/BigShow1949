//
//  Teacher.m
//  test2
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Teacher_MMF.h"
#import "Doctor_MMF.h"

@implementation Teacher_MMF

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    Doctor_MMF *doctor = [[Doctor_MMF alloc]init];
    if ([doctor respondsToSelector:aSelector]) {
        return doctor;
    }
    return nil;
}
@end
