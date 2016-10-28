//
//  Person.h
//  Cocopods
//
//  Created by 杨帆 on 16/7/6.
//  Copyright © 2016年 BigShowCompany. All rights reserved.
//

#import "Model.h"
#import "Classes.h"
#import "Teacher.h"

@interface Person : Model

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) Classes *classes; // 选课科目(只选一个科目)
@property (nonatomic, strong) Teacher *teachers; // 老师


@end
