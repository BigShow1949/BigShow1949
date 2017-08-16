//
//  JLHomePracticeViewController.m
//  MVVM-DataController-Demo
//
//  Created by skyline on 16/3/15.
//  Copyright © 2016年 skyline. All rights reserved.
//

#import "JLHomePracticeViewController.h"
#import "JLHomePracticeActivityView.h"
#import "JLHomePracticeBannerView.h"
#import "JLHomePracticeSubjectsView.h"

#import "JLHomePracticeDataController.h"

@interface JLHomePracticeViewController ()<UICollectionViewDelegate>

@property (nonatomic, strong, nullable) UIScrollView *contentView;

@property (nonatomic, strong, nullable) JLHomePracticeBannerView *bannerView;
@property (nonatomic, strong, nullable) JLHomePracticeActivityView *activityView;
@property (nonatomic, strong, nullable) JLHomePracticeSubjectsView *subjectsView;

@property (nonatomic, strong, nullable) JLHomePracticeDataController *dataController;

@end

@implementation JLHomePracticeViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    _dataController = [[JLHomePracticeDataController alloc] init];
    self.view.backgroundColor = [UIColor lightGrayColor];

    [self setupContentView];
    [self fetchSubjectData];
}

- (void)setupContentView {
    self.contentView = [[UIScrollView alloc] init];
    [self.view addSubview:self.contentView];

    self.bannerView = [[JLHomePracticeBannerView alloc] init];
    self.activityView = [[JLHomePracticeActivityView alloc] init];
    self.subjectsView = [[JLHomePracticeSubjectsView alloc] init];

    [self.contentView addSubview:self.bannerView];
    [self.contentView addSubview:self.activityView];
    [self.contentView addSubview:self.subjectsView];


    self.bannerView.frame = CGRectMake(0, 20, 320, 180);
    self.activityView.frame = CGRectMake(0, 200, 320, 70);
    self.subjectsView.frame = CGRectMake(0, 270, 200, 200);
    self.contentView.frame = CGRectMake(0, 0, 320, 568);

}

#pragma mark -  Data
- (void)fetchSubjectData {
    [self.dataController requestSubjectDataWithCallback:^(NSError *error) {
        if (error == nil) {
            [self renderSubjectView];
        }
    }];
}


- (void)renderSubjectView {
    JLHomePracticeSubjectsViewModel *viewModel =
    [JLHomePracticeSubjectsViewModel viewModelWithSubjects:self.dataController.openSubjects];
    [self.subjectsView bindDataWithViewModel:viewModel];
}

@end
