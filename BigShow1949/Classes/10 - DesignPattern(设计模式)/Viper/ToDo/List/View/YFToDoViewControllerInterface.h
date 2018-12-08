//
//  YFToDoViewControllerInterface.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFToDoViewControllerInterface_h
#define YFToDoViewControllerInterface_h

@class VTDUpcomingDisplayData;

@protocol YFToDoViewControllerDelegate
- (void)showNoContentMessage;
- (void)showUpcomingDisplayData:(VTDUpcomingDisplayData *)data;
- (void)reloadEntries;
@end

#endif /* YFToDoViewControllerInterface_h */
