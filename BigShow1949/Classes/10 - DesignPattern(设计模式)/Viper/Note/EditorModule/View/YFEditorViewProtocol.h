//
//  YFEditorViewViewProtocol.h
//  BigShow1949
//
//  Created by big show on 2018/12/9.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFEditorViewProtocol_h
#define YFEditorViewProtocol_h

typedef NS_ENUM(NSInteger,YFEditorMode) {
    YFEditorModeCreate,
    YFEditorModeModify
};

@protocol YFEditorDelegate;

@protocol YFEditorViewProtocol

@property (nonatomic, weak) id<YFEditorDelegate> delegate;
@property (nonatomic, assign) YFEditorMode editMode;
- (nullable NSString *)titleString;
- (nullable NSString *)contentString;

- (void)updateTitleString:(NSString *)title;
- (void)updateContentString:(NSString *)content;
@end

#endif /* YFEditorViewViewProtocol_h */
