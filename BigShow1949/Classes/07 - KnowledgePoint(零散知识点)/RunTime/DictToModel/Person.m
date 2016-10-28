//
//  Person.m
//  Cocopods
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Person.h"


//#import "NSObject+Model.h"

@implementation Person


- (NSString *)description {

    return [NSString stringWithFormat:@"name = %@, userId = %@, [classes = %@], [teachers = %@]", self.name, self.userId, self.classes, self.teachers];
}

@end
