//
//  YFToDoPresenter.m
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoPresenter.h"

@implementation YFToDoPresenter


#pragma mark - YFToDoPresenterDelegate
- (void)updateView {
    NSLog(@"interactor ==== %p", self.interactor);
    [self.interactor findUpcomingItems];
}

- (void)addNewEntry {
    
}


#pragma mark - YFToDoInteractorOutput
- (void)foundUpcomingItems:(NSArray *)upcomingItems {
    if ([upcomingItems count] == 0) {
        [self.viewController showNoContentMessage];
    } else {
        [self.viewController showUpcomingDisplayData:@[]];
    }
}


@end
