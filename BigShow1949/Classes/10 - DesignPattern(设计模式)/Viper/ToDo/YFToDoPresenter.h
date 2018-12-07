//
//  YFToDoPresenter.h
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFToDoProtocols.h"
#import "YFToDoItem.h"

NS_ASSUME_NONNULL_BEGIN
@interface YFToDoPresenter : NSObject<ToDoInteractorOutputProtocol>
@property (nonatomic, weak, nullable) id<ToDoViewProtocol> view;
@property (nonatomic) id<ToDoInteractorInputProtocol> interactor;
@property (nonatomic, weak) id<ToDoWireframeProtocol> router;

- (instancetype)initWithInterface:(id<ToDoViewProtocol>)interface
                       interactor:(id<ToDoInteractorInputProtocol>)interactor
                           router:(id<ToDoWireframeProtocol>)router;
- (void)addToDoItem:(YFToDoItem *)item;
@end
NS_ASSUME_NONNULL_END
