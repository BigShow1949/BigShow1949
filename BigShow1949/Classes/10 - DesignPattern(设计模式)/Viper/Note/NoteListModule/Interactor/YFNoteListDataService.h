//
//  YFNoteListDataService.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFNoteListDataService_h
#define YFNoteListDataService_h

@class YFNoteModel;
@protocol YFNoteListDataService

@property (nonatomic, readonly, strong) NSArray<YFNoteModel *> *noteList;
- (void)fetchAllNotesWithCompletion:(void(^)(NSArray *notes))completion;
- (void)storeNote:(YFNoteModel *)note;
- (void)deleteNote:(YFNoteModel *)noteToDelete;

@end

#endif /* YFNoteListDataService_h */
