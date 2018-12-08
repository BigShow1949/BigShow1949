//
//  YFToDoInteractorInterface.h
//  BigShow1949
//
//  Created by big show on 2018/12/8.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFToDoInteractorInterface_h
#define YFToDoInteractorInterface_h

@protocol YFToDoInteractorInput
- (void)findUpcomingItems;

@end

@protocol YFToDoInteractorOutput
- (void)foundUpcomingItems:(NSArray *)upcomingItems;

@end

#endif /* YFToDoInteractorInterface_h */
