//
//  HomePresenter.m
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import "HomePresenter.h"
#import "HomeModel.h"

#import "YYModel.h"

@interface HomePresenter()

@end

@implementation HomePresenter

- (void)getMovieListWithUrlString:(NSString *)urlString{
    [self.httpClient get:urlString parameters:nil];
}
#pragma mark - HttpResponseHandle

- (void)onSuccess:(id)responseObject{
    // 这里崩溃了
    HomeModel *model = [HomeModel yy_modelWithJSON:responseObject];
    if ([_view respondsToSelector:@selector(onGetMovieListSuccess:)]) {
        [_view onGetMovieListSuccess:model];
    }
}

- (void)onFail:(id)clientInfo errCode:(NSInteger)errCode errInfo:(NSString *)errInfo{
    if ([_view respondsToSelector: @selector(onGetMovieListFail: des:)]) {
        [_view onGetMovieListFail:errCode des:errInfo];
    }
}
@end
