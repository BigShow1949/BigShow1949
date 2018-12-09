//
//  YFEditorInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFEditorInteractor.h"
#import "YFNoteModel.h"

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

@end
