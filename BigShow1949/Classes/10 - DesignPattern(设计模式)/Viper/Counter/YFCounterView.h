//
//  YFCounterView.h
//  BigShow1949
//
//  Created by big show on 2018/10/15.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//


@protocol YFCounterView <NSObject>
- (void)setCountText:(NSString*)countText;
- (void)setDecrementEnabled:(BOOL)enabled;
@end
