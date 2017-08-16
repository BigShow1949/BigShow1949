//
//  Car_Msg.m
//  BigShow1949
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Car_Msg.h"

@implementation Car_Msg
- (void)run
{
    NSLog(@"Car:%@ %s", self, sel_getName(_cmd));
}
@end
