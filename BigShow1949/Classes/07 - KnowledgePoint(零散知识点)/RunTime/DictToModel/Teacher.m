//
//  Teacher.m
//  Cocopods
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (NSString *)description {
    
    return [NSString stringWithFormat:@"{teaName = %@, teaAge = %@}", self.teaName , self.teaAge];
}
@end
