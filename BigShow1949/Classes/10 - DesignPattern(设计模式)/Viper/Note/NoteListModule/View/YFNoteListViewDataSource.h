//
//  YFNoteListViewDataSource.h
//  BigShow1949
//
//  Created by big show on 2018/10/18.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//


#import <Foundation/Foundation.h>
@protocol YFNoteListViewDataSource <NSObject>
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


