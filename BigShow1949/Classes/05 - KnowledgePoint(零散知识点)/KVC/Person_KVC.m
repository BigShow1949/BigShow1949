//
//  Person_KVC.m
//  BigShow1949
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Person_KVC.h"

@implementation Person_KVC


- (NSString *)description{
    NSLog(@"%@",_name);
    return _name;
}

@end
