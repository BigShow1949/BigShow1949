//
//  UPStackMenuItem.h
//  UPStackButtonDemo
//
//  Created by Paul Ulric on 21/01/2015.
//  Copyright (c) 2015 Paul Ulric. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    UPStackMenuItemLabelPosition_left = 0,
    UPStackMenuItemLabelPosition_right
} UPStackMenuItemLabelPosition_e;


@protocol UPStackMenuItemDelegate;


@interface UPStackMenuItem : UIView

@property (nonatomic, strong)            UIImage                         *image;
@property (nonatomic, strong)            UIImage                         *highlightedImage;
@property (nonatomic, strong)            NSString                        *title;
@property (nonatomic, readwrite)         UPStackMenuItemLabelPosition_e  labelPosition;

@property (nonatomic, unsafe_unretained) id<UPStackMenuItemDelegate>     delegate;


- (id)initWithImage:(UIImage*)image;
- (id)initWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage title:(NSString*)title;
- (id)initWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage title:(NSString*)title font:(UIFont*)font;

- (void)expandAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration;
- (void)reduceAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration;

- (CGPoint)itemCenter;
- (CGPoint)centerForItemCenter:(CGPoint)itemCenter;

- (void)setTitleColor:(UIColor*)color;

@end



@protocol UPStackMenuItemDelegate <NSObject>

@optional
- (void)didTouchStackMenuItem:(UPStackMenuItem*)item;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com