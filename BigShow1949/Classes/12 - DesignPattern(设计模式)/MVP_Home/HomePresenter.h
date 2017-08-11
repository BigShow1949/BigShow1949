//
//  HomePresenter.h
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import "HttpPresenter.h"
#import "HomeViewProtocol.h"

@interface HomePresenter : HttpPresenter <id<HomeViewProtocol>>

- (void)getMovieListWithUrlString:(NSString *)urlString;
@end
