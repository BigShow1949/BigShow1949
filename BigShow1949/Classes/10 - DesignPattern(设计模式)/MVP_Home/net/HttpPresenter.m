//
//  HttpPresenter.m
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import "HttpPresenter.h"

@implementation HttpPresenter
- (instancetype) initWithView:(id)view{
    if (self = [super initWithView:view]) {
        _httpClient = [[HttpClient alloc] initWithHandle:self];
    }
    return self;
}
#pragma mark - HttpResponseHandle
- (void)onSuccess:(id)responseObject{
    
}

- (void)onFail:(id)clientInfo errCode:(NSInteger)errCode errInfo:(NSString *)errInfo{

}
@end
