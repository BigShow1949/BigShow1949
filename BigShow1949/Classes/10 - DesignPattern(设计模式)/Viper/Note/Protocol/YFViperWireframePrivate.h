//
//  YFViperWireframePrivate.h
//  BigShow1949
//
//  Created by big show on 2018/10/17.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFViperWireframe.h"
#import "YFViperRouter.h"
#import "YFViperView.h"

@protocol YFViperWireframePrivate<YFViperWireframe>
- (void)setView:(id<YFViperView>)view;
- (id<YFViperRouter>)router;
- (void)setRouter:(id<YFViperRouter>)router;

@end
