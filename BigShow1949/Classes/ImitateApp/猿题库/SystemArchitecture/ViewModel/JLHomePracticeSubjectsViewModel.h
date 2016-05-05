//
//  JLHomePracticeSubjectsViewModel.h
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLHomePracticeSubjectsCollectionCellViewModel.h"
#import "JLSubject.h"

@interface JLHomePracticeSubjectsViewModel : NSObject

@property (nonatomic, strong, nonnull) NSArray<JLHomePracticeSubjectsCollectionCellViewModel *>
*cellViewModels;

@property (nonatomic, strong, nonnull) UIColor *backgroundColor;

+ (nonnull JLHomePracticeSubjectsViewModel *)viewModelWithSubjects:(nonnull NSArray<JLSubject *>
                                                                     *)subjects;

@end
