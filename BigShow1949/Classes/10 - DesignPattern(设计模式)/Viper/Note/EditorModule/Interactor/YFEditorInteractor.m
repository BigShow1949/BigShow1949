//
//  YFEditorInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFEditorInteractor.h"
#import "YFNoteModel.h"
#import "YFNoteDataManager.h"
#import "YFEditorInteractorDataSource.h"

@interface YFEditorInteractor()
@property (nonatomic, strong, nullable) YFNoteModel *currentEditingNote;

@end

@implementation YFEditorInteractor
- (instancetype)initWithEditingNote:(nullable YFNoteModel*)note {
    if (self = [super init]) {
        if (note) {
            _currentEditingNote = note;
        }
    }
    return self;
}
@synthesize dataSource;

@synthesize eventHandler;

#pragma mark - YFEditorInteractorInput
- (nullable YFNoteModel *)currentEditingNote {
    NSLog(@"dataSource = %@", self.dataSource);
    NSString *title = [self.dataSource currentEditingNoteTitle];
    NSString *content = [self.dataSource currentEditingNoteContent];
    if (!title && !content) {
        return nil;
    }
    if (!_currentEditingNote) {
        _currentEditingNote = [[YFNoteModel alloc] initWithNewNoteForTitle:title content:content];
    } else {
        _currentEditingNote = [[YFNoteModel alloc] initWithUUID:_currentEditingNote.uuid title:title content:content];
    }
    return _currentEditingNote;
}

- (void)storeCurrentEditingNote {
    if (self.currentEditingNote.title.length == 0) {
        return;
    }
    [[YFNoteDataManager sharedInsatnce] storeNote:self.currentEditingNote];
}

- (nullable NSString *)currentEditingNoteTitle {
    return _currentEditingNote.title;
}
- (nullable NSString *)currentEditingNoteContent {
    return _currentEditingNote.content;
}

@end
