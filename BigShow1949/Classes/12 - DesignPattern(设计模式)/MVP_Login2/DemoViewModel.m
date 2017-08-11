//
//  DemoViewModel.m
//  BigShow1949
//
//  Created by apple on 17/8/11.
//  Copyright © 2017年 BigShowCompany. All rights reserved.
//

#import "DemoViewModel.h"
#import "PasswordValidator.h"

@implementation DemoViewModel


- (bool) isPasswordValid
{
    return [PasswordValidator isValid:_password];
}

@end
