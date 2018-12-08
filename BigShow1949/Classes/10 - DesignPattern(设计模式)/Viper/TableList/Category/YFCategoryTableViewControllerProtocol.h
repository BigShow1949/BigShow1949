//
//  YFCategoryTableViewControllerProtocol.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFCategoryTableViewControllerProtocol_h
#define YFCategoryTableViewControllerProtocol_h

@protocol YFCategoryTableViewControllerDelegate
@required
- (void)updateTableView:(NSArray *)array;
@end

#endif /* YFCategoryTableViewControllerProtocol_h */
