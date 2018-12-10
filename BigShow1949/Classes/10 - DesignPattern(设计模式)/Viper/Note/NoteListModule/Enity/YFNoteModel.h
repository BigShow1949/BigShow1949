//
//  YFNoteModel.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFNoteModel : NSObject<NSCoding>
@property (nonatomic, readonly, copy) NSString *uuid;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *content;

- (instancetype)initWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNewNoteForTitle:(NSString *)title content:(NSString *)content;
@end
