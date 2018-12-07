//
//  YFToDoProtocols.m
//  
//
//  Created by big show on 2018/12/7.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "YFToDoItem.h"

#pragma mark - WireFrameProtocol

@protocol ToDoWireframeProtocol <NSObject>

@end

#pragma mark - PresenterProtocol

@protocol ToDoPresenterProtocol <NSObject>

@end

#pragma mark - InteractorProtocol

@protocol ToDoInteractorOutputProtocol <NSObject>

- (void)sendAddedItem:(YFToDoItem *)item;

@end

@protocol ToDoInteractorInputProtocol <NSObject>

- (void)setOutput:(id<ToDoInteractorOutputProtocol>)output;
- (id<ToDoInteractorOutputProtocol>)getOutputProtocol;

- (void)addToDoItem:(YFToDoItem *)item;

@end

#pragma mark - ViewProtocol

@protocol ToDoViewProtocol <NSObject>

- (void)showAddedItem:(YFToDoItem *)item;

@end
