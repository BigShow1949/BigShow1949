//
//  JLHomePracticeSubjectsCollectionViewCell.h
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLHomePracticeSubjectsCollectionCellViewModel.h"

@interface JLHomePracticeSubjectsCollectionViewCell : UICollectionViewCell

- (void)bindDataWithViewModel:(nonnull JLHomePracticeSubjectsCollectionCellViewModel *)viewModel;

@end
