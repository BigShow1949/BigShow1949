//
//  JLHomePracticeSubjectsCollectionCellViewModel.h
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLSubject.h"

@interface JLHomePracticeSubjectsCollectionCellViewModel : NSObject

@property (nonatomic, strong, nonnull) UIImage *image;
@property (nonatomic, strong, nonnull) UIImage *highlightedImage;
@property (nonatomic, strong, nonnull) NSString *title;
@property (nonatomic, strong, nonnull) UIColor *titleColor;
@property (nonatomic, strong, nonnull) UIColor *backgroundColor;

+ (nonnull JLHomePracticeSubjectsCollectionCellViewModel *)viewModelWithSubject:(nonnull JLSubject *)subject;
+ (nonnull JLHomePracticeSubjectsCollectionCellViewModel *)viewModelForMore;

@end
