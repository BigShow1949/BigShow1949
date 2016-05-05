//
//  JLHomePracticeSubjectsCollectionViewCell.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLHomePracticeSubjectsCollectionViewCell.h"

@interface JLHomePracticeSubjectsCollectionViewCell ()

@property (nonatomic, strong, nonnull) UILabel *label;

@end

@implementation JLHomePracticeSubjectsCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _label.center = self.contentView.center;
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)bindDataWithViewModel:(JLHomePracticeSubjectsCollectionCellViewModel *)viewModel {
    [_label setText:viewModel.title];
    [_label setTextColor:viewModel.titleColor];
}
@end
