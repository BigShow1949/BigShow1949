//
//  PasswordValidator.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "PasswordValidator.h"

@implementation PasswordValidator
+ (bool)isValid:(NSString*)password {
    if ([password length] >=6) {
        return true;
    }
    return false;
}
@end
