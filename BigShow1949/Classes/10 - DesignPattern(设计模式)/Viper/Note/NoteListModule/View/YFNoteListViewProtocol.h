//
//  YFNoteListViewProtocol.h
//  BigShow1949
//
//  Created by big show on 2018/10/18.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFNoteListViewProtocol_h
#define YFNoteListViewProtocol_h

#import <Foundation/Foundation.h>

//#define _ZIKTNoteListViewProtocol_ (Protocol<ZIKTRoutableViewDynamicGetter> *)@protocol(ZIKTNoteListViewProtocol)
@protocol YFNoteListViewProtocol <NSObject>
- (UITableView *)tableView;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
                                      text:(NSString *)text
                                detailText:(NSString *)detailText;
@end

#endif /* YFNoteListViewProtocol_h */
