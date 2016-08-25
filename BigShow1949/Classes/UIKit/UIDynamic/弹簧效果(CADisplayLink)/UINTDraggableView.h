//
// Created by Florian on 21/04/14.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Animator.h"


@class UINTDraggableView;


@protocol DraggableViewDelegate

- (void)draggableView:(UINTDraggableView *)view draggingEndedWithVelocity:(CGPoint)velocity;
- (void)draggableViewBeganDragging:(UINTDraggableView *)view;

@end


@interface UINTDraggableView : UIView

@property (nonatomic, weak) id <DraggableViewDelegate> delegate;

@end