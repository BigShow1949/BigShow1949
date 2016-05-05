//
//  JLHomePracticeDataController.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLHomePracticeDataController.h"
#import "JLSubjectDataController.h"

@interface JLHomePracticeDataController ()

@property (nonatomic, strong, nonnull) JLSubjectDataController *subjectDataController;

@end

@implementation JLHomePracticeDataController

- (instancetype)init {
    self = [super init];
    if (self) {
        _subjectDataController = [[JLSubjectDataController alloc] init];
    }
    return self;
}

- (void)requestSubjectDataWithCallback:(nonnull JLCompletionCallback)callback {
    [self.subjectDataController requestAllSubjects];
    [self.subjectDataController requestUserSubjects];
    // 模拟网络请求延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback(nil);
    });
}

- (NSArray<JLSubject *> *)openSubjects {
    return self.subjectDataController.openSubjectsWithCurrentPhase ? : @[];
}

@end
