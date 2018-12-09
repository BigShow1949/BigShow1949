//
//  YFNoteListInteractorInput.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YFNoteModel;
@protocol YFNoteListInteractorInput
- (void)loadAllNotes;
- (NSInteger)noteCount;
- (NSString *)titleForNoteAtIndex:(NSUInteger)idx;
- (NSString *)contentForNoteAtIndex:(NSUInteger)idx;

- (YFNoteModel *)noteAtIndex:(NSUInteger)idx;
- (NSString *)noteUUIDAtIndex:(NSUInteger)idx;
- (NSString *)noteTitleAtIndex:(NSUInteger)idx;
- (NSString *)noteContentAtIndex:(NSUInteger)idx;
- (void)deleteNoteAtIndex:(NSUInteger)idx;

@end
