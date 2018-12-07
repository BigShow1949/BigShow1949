//
//  YFCounterInteractorIO.h
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#ifndef YFCounterInteractorIO_h
#define YFCounterInteractorIO_h

@protocol YFCounterInteractorInput <NSObject>
- (void)requestCount;
- (void)increment;
- (void)decrement;
@end

@protocol YFCounterInteractorOutput <NSObject>
- (void)updateCount:(NSUInteger)count;
@end

#endif /* YFCounterInteractorIO_h */
