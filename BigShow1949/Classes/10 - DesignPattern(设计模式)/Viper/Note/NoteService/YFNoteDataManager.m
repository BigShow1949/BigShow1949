//
//  YFNoteDataManager.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteDataManager.h"

@implementation YFNoteDataManager
+ (instancetype)sharedInsatnce {
    static YFNoteDataManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[YFNoteDataManager alloc] init];
    });
    return shared;
}
@end
