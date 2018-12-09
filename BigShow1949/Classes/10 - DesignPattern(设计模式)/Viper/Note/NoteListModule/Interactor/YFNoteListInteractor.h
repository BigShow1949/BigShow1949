//
//  YFNoteListInteractor.h
//  BigShow1949
//
//  Created by big show on 2018/10/16.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFViperInteractor.h"
#import "YFNoteListInteractorInput.h"
@protocol YFNoteListDataService;
@interface YFNoteListInteractor : NSObject<YFViperInteractor,YFNoteListInteractorInput>
@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;
- (instancetype)initWithNoteListDataService:(id<YFNoteListDataService>)service;
@end
