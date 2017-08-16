//
//  My.m
//  test2
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "My.h"

@implementation My

- (void)willbuy {
    [_delegate buyIphone:@"iphone" money:@"5000"];
}

-(void)buyIphone:(NSString *)iphoneType money:(NSString *)money {
    [_delegate buyIphone:iphoneType money:money];
}
@end
