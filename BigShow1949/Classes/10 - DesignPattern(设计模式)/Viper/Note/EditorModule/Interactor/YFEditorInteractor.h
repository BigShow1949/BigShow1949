//
//  YFEditorInteractor.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFViperInteractor.h"
#import "YFEditorInteractorInput.h"

@class YFNoteModel;
@protocol YFEditorInteractorDataSource;
@protocol YFEditorInteractorEventHandler;

@interface YFEditorInteractor : NSObject<YFViperInteractor,YFEditorInteractorInput>
@property (nonatomic, weak) id<YFEditorInteractorDataSource> dataSource;
@property (nonatomic, weak) id<YFEditorInteractorEventHandler> eventHandler;

- (instancetype)initWithEditingNote:(nullable YFNoteModel *)note;
@end
