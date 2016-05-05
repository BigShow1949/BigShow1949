//
//  JLHomePracticeSubjectsCollectionCellViewModel.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLHomePracticeSubjectsCollectionCellViewModel.h"

@implementation JLHomePracticeSubjectsCollectionCellViewModel

+ (nonnull JLHomePracticeSubjectsCollectionCellViewModel *)viewModelWithSubject:(nonnull JLSubject *)subject {
    JLHomePracticeSubjectsCollectionCellViewModel *vm = [[JLHomePracticeSubjectsCollectionCellViewModel alloc] init];
    vm.backgroundColor = [UIColor whiteColor];
    vm.title = subject.name;
    vm.titleColor = [UIColor greenColor];
    return vm;
}

+ (nonnull JLHomePracticeSubjectsCollectionCellViewModel *)viewModelForMore {
    JLHomePracticeSubjectsCollectionCellViewModel *vm = [[JLHomePracticeSubjectsCollectionCellViewModel alloc] init];
    return vm;
}

@end
