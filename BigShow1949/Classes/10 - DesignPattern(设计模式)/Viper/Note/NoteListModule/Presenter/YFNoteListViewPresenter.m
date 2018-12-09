//
//  YFNoteListViewPresenter.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteListViewPresenter.h"
#import "YFViperView.h"
#import "YFNoteListWireframeInput.h"
#import "YFViperInteractor.h"

@interface YFNoteListViewPresenter ()
@property (nonatomic, weak) id<YFViperView>view;
@property (nonatomic, strong) id<YFNoteListWireframeInput> wireframe;
@property (nonatomic, strong) id<YFViperInteractor> interactor;



@end


@implementation YFNoteListViewPresenter


#pragma mark - YFViperPresenter

#pragma mark - YFNoteListViewEventHandler
- (void)didTouchNavigationBarAddButton {}

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath {return YES;}
- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - YFViperViewEventHandler
- (void)handleViewReady {}
- (void)handleViewRemoved {}
- (void)handleViewWillAppear:(BOOL)animated {}
- (void)handleViewDidAppear:(BOOL)animated {}
- (void)handleViewWillDisappear:(BOOL)animated {}
- (void)handleViewDidDisappear:(BOOL)animated {}

#pragma mark - YFNoteListViewDataSource
- (NSInteger)numberOfRowsInSection:(NSInteger)section {return 3;}
- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {return @"1";}
- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {return @"2";}



@end
