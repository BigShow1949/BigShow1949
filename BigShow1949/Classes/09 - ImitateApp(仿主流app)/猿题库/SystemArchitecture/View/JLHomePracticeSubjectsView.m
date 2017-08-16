//
//  APEHomePracticeSubjectsView.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLHomePracticeSubjectsView.h"
#import "JLHomePracticeSubjectsCollectionViewCell.h"

@interface JLHomePracticeSubjectsView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, nullable, readwrite) JLHomePracticeSubjectsViewModel *viewModel;
@property (nonatomic, strong, nonnull) UICollectionView *collectionView;
@end

@implementation JLHomePracticeSubjectsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[JLHomePracticeSubjectsCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self addSubview:_collectionView];
    }
    return self;
}

- (void)bindDataWithViewModel:(nonnull JLHomePracticeSubjectsViewModel *)viewModel {
    self.viewModel = viewModel;
    self.backgroundColor = viewModel.backgroundColor;
    [self.collectionView reloadData];
    [self setNeedsUpdateConstraints];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:
(NSIndexPath *)indexPath {
    JLHomePracticeSubjectsCollectionViewCell *cell = [collectionView
                                                       dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (0 <= indexPath.row && indexPath.row < self.viewModel.cellViewModels.count) {
        JLHomePracticeSubjectsCollectionCellViewModel *vm =
        self.viewModel.cellViewModels[indexPath.row];
        [cell bindDataWithViewModel:vm];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.cellViewModels.count;
}

@end

