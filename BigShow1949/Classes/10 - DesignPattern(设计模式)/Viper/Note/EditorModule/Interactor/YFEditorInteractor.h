//
//  YFEditorInteractor.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFViperInteractor.h"

@class YFNoteModel;
@interface YFEditorInteractor : NSObject<YFViperInteractor>
- (instancetype)initWithEditingNote:(nullable YFNoteModel *)note;
@end
