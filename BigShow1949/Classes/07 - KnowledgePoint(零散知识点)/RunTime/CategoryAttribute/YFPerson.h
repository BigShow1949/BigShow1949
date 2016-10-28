//
//  YFPerson.h
//  BigShow1949
//
//  Created by zhht01 on 16/4/14.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

-(void)run;
+ (instancetype)personWithDict:(NSDictionary *)dict;
@end
