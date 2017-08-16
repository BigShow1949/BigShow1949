//
//  JLHomePracticeDataController.h
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLBaseDataController.h"
#import "JLSubject.h"

@interface JLHomePracticeDataController : JLBaseDataController

@property (nonatomic, strong, nullable) NSArray<JLSubject *> *openSubjects;

- (void)requestSubjectDataWithCallback:(nonnull JLCompletionCallback)callback;

@end
