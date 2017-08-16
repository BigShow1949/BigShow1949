//
//  JLSubjectDataController.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLSubjectDataController.h"
#import "JLSubject.h"

@interface JLSubjectDataController ()

@property (nonatomic, copy, nullable) NSArray<JLSubject *> *allSubjects;
@property (nonatomic, copy, nullable) NSArray<JLSubject *> *userSubjects;

@end

@implementation JLSubjectDataController

- (void)requestAllSubjects {
    // 假数据
    JLSubject *math = [[JLSubject alloc] init];
    math.name = @"数学";
    math.id = @1;

    JLSubject *eng = [[JLSubject alloc] init];
    eng.name = @"英语";
    eng.id = @2;

    JLSubject *chem = [[JLSubject alloc] init];
    chem.name = @"化学";
    chem.id = @3;

    JLSubject *phy = [[JLSubject alloc] init];
    phy.name = @"物理";
    phy.id = @4;

    _allSubjects = @[math, eng, chem, phy];
}

- (void)requestUserSubjects {
    JLSubject *math = [[JLSubject alloc] init];
    math.name = @"数学";
    math.id = @1;

    JLSubject *eng = [[JLSubject alloc] init];
    eng.name = @"英语";
    eng.id = @2;

    JLSubject *chem = [[JLSubject alloc] init];
    chem.name = @"化学";
    chem.id = @3;

    JLSubject *phy = [[JLSubject alloc] init];
    phy.name = @"物理";
    phy.id = @4;

    _userSubjects = @[math, eng, chem, phy];
}

- (NSArray<JLSubject *> *)openSubjectsWithCurrentPhase {
    return _allSubjects;
}

@end
