//
//  YFToDoPresenter.m
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoPresenter.h"

@implementation YFToDoPresenter
- (instancetype)initWithInterface:(id<ToDoViewProtocol>)interface
                       interactor:(id<ToDoInteractorInputProtocol>)interactor
                           router:(id<ToDoWireframeProtocol>)router
{
    if (self = [super init])
    {
        self.view = interface;
        self.interactor = interactor;
        self.router = router;
        [self.interactor setOutput:self];
    }
    return self;
}

- (void)addToDoItem:(YFToDoItem *)item
{
    [self.interactor addToDoItem:item];
}


#pragma mark - ToDoInteractorOutputProtocol

- (void)sendAddedItem:(YFToDoItem *)item
{
    [self.view showAddedItem:item];
}

@end
