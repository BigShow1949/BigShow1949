//
//  UPStackMenu.h
//  UPStackButtonDemo
//
//  Created by Paul Ulric on 21/01/2015.
//  Copyright (c) 2015 Paul Ulric. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UPStackMenuItem.h"


typedef enum {
    UPStackMenuStackPosition_up = 0,
    UPStackMenuStackPosition_down
} UPStackMenuStackPosition_e;

typedef enum {
    UPStackMenuAnimationType_linear = 0,
    UPStackMenuAnimationType_progressive,
    UPStackMenuAnimationType_progressiveInverse
} UPStackMenuAnimationType_e;


@protocol UPStackMenuDelegate;


@interface UPStackMenu : UIView <UPStackMenuItemDelegate>

// Vertical spacing between each stack menu item
@property (nonatomic, readwrite)            CGFloat                     itemsSpacing;
// Whether the items should bounce at the end of the opening animation, or a the beginning of the closing animaton
@property (nonatomic, readwrite)            BOOL                        bouncingAnimation;
// Opening animation total duration (in seconds)
@property (nonatomic, readwrite)            NSTimeInterval              openAnimationDuration;
// Closing animation total duration (in seconds)
@property (nonatomic, readwrite)            NSTimeInterval              closeAnimationDuration;
// Delay between each item animation start during opening (in seconds)
@property (nonatomic, readwrite)            NSTimeInterval              openAnimationDurationOffset;
// Delay between each item animation start during closing (in seconds)
@property (nonatomic, readwrite)            NSTimeInterval              closeAnimationDurationOffset;
@property (nonatomic, readwrite)            UPStackMenuStackPosition_e  stackPosition;
@property (nonatomic, readwrite)            UPStackMenuAnimationType_e  animationType;
@property (nonatomic, readonly)             BOOL                        isOpen;
@property (nonatomic, unsafe_unretained)    id<UPStackMenuDelegate>     delegate;


- (id)initWithContentView:(UIView*)contentView;

- (void)addItem:(UPStackMenuItem*)item;
- (void)addItems:(NSArray*)items;
- (void)removeItem:(UPStackMenuItem*)item;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)removeAllItems;

- (NSArray*)items;

- (void)openStack;
- (void)closeStack;

@end



@protocol UPStackMenuDelegate <NSObject>

@optional
- (void)stackMenuWillOpen:(UPStackMenu*)menu;
- (void)stackMenuDidOpen:(UPStackMenu*)menu;
- (void)stackMenuWillClose:(UPStackMenu*)menu;
- (void)stackMenuDidClose:(UPStackMenu*)menu;
- (void)stackMenu:(UPStackMenu*)menu didTouchItem:(UPStackMenuItem*)item atIndex:(NSUInteger)index;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com