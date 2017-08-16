//
//  Presenter.h
//  MVP
//
//  Created by baoshan on 17/2/8.
//  Copyright © 2017年 hans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Presenter<E>: NSObject{

    //MVP中负责更新的视图
    __weak E _view;
}


/**
 初始化函数

 @param view 要绑定的视图
 */
- (instancetype) initWithView:(E)view;

/**
 * 绑定视图
 * @param view 要绑定的视图
 */
- (void) attachView:(E)view ;

/**
 解绑视图
 */
- (void)detachView;
@end
