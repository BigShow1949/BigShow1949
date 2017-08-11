//
//  HttpPresenter.h
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import "Presenter.h"
#import "HttpResponseHandle.h"
#import "HttpClient.h"

@interface HttpPresenter<E> : Presenter<E> <HttpResponseHandle>

@property (nonatomic,strong)HttpClient *httpClient;

@end
