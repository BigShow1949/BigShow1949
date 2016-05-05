//
//  JLHomePracticeSubjectsViewModel.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLHomePracticeSubjectsViewModel.h"

@implementation JLHomePracticeSubjectsViewModel

+ (nonnull JLHomePracticeSubjectsViewModel *)viewModelWithSubjects:(nonnull NSArray<JLSubject *>
                                                                    *)subjects {
    NSMutableArray<JLHomePracticeSubjectsCollectionCellViewModel *> *arr = [[NSMutableArray alloc] initWithCapacity:subjects.count];
    [subjects enumerateObjectsUsingBlock:^(JLSubject * _Nonnull subject, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[JLHomePracticeSubjectsCollectionCellViewModel viewModelWithSubject:subject]];
    }];
    JLHomePracticeSubjectsViewModel *vm = [[JLHomePracticeSubjectsViewModel alloc] init];
    vm.cellViewModels = [arr copy];
    vm.backgroundColor = [UIColor whiteColor];
    return vm;
}

@end
