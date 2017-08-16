//
//  HttpUtils.h
//  Dream_Architect_MVP_OC
//
//  Created by Apple on 2017/2/7.
//  Copyright © 2017年 乔布永. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Callback) (NSString* result);
@interface HttpUtils : NSObject
+ (void)postWithName:(NSString*)name pwd:(NSString*)pwd callback:(Callback)callback;

@end
