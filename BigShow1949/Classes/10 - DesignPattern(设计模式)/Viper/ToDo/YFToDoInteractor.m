//
//  YFToDoInteractor.m
//  BigShow1949
//
//  Created by big show on 2018/12/7.
//  Copyright © 2018年 BigShowCompany. All rights reserved.
//

#import "YFToDoInteractor.h"
#import "YFToDoItem.h"

@implementation YFToDoInteractor
#pragma mark - InteractorProtocol

- (void)setOutput:(id<ToDoInteractorOutputProtocol>)output
{
    _output = output;
}

- (id<ToDoInteractorOutputProtocol>)getOutputProtocol
{
    return self.output;
}

- (void)addToDoItem:(YFToDoItem *)item
{
    [self.output sendAddedItem:item];
}
@end
