//
//  YFNoteListInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFNoteListInteractor.h"
#import "YFNoteModel.h"
#import "YFNoteListDataService.h"
@interface YFNoteListInteractor ()
@property (nonatomic, strong) id<YFNoteListDataService> noteListDataService;

@end

@implementation YFNoteListInteractor
- (instancetype)initWithNoteListDataService:(id<YFNoteListDataService>)service {
    if (self = [super init]) {
        self.noteListDataService = service;
    }
    return self;
}

#pragma mark - Public


#pragma mark - Private
- (NSArray<YFNoteModel *> *)noteList {
    return self.noteListDataService.noteList;
}

#pragma mark - YFViperInteractor

#pragma mark - YFNoteListInteractorInput

- (void)loadAllNotes {
    [self.noteListDataService fetchAllNotesWithCompletion:^(NSArray *notes) {
        NSLog(@"count = %d", self.noteList.count);

    }];
}

- (NSInteger)noteCount {
    return self.noteList.count;
}
- (NSString *)titleForNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return self.noteList[idx].title;
}
- (NSString *)contentForNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return self.noteList[idx].content;
}

- (YFNoteModel *)noteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return self.noteList[idx];
}
- (NSString *)noteUUIDAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return self.noteList[idx].uuid;
}
- (NSString *)noteTitleAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return self.noteList[idx].title;
}
- (NSString *)noteContentAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return self.noteList[idx].content;
}
- (void)deleteNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return;
    }
    YFNoteModel *note = [self noteAtIndex:idx];
    [self.noteListDataService deleteNote:note];
}



@end
