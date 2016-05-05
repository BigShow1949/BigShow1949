//
//  UPStackMenuItem.m
//  UPStackButtonDemo
//
//  Created by Paul Ulric on 21/01/2015.
//  Copyright (c) 2015 Paul Ulric. All rights reserved.
//

#import "UPStackMenuItem.h"


const static CGFloat kStackItemInternMargin = 6;

const static UPStackMenuItemLabelPosition_e kStackMenuItemDefaultLabelPosition  = UPStackMenuItemLabelPosition_left;


@interface UPStackMenuItem() {
    UIButton *_imageButton;
    UILabel *_label;
    UIView *_labelContainer;
    UIButton *_button;
    
    BOOL _isExpanded;
    BOOL _isAnimating;
}
@end


@implementation UPStackMenuItem

- (id)initWithImage:(UIImage*)image
{
    return [self initWithImage:image highlightedImage:nil title:nil];
}

- (id)initWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage title:(NSString*)title
{
    return [self initWithImage:image highlightedImage:highlightedImage title:title font:nil];
}

- (id)initWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage title:(NSString*)title font:(UIFont*)font
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        _image = image;
        _highlightedImage = highlightedImage;
        _title = title;

        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageButton setImage:_image forState:UIControlStateNormal];
        if(_highlightedImage)
            [_imageButton setImage:_highlightedImage forState:UIControlStateHighlighted];
        [_imageButton setFrame:CGRectMake(0, 0,
                                          MAX(_image.size.width, _highlightedImage.size.width),
                                          MAX(_image.size.height, _highlightedImage.size.height))];
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        [_label setLineBreakMode:NSLineBreakByClipping];
        [_label setText:_title];
        if(font)
            [_label setFont:font];
        CGSize labelSize = [_title sizeWithAttributes:@{NSFontAttributeName : _label.font}];
        [_label setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        
        _labelContainer = [[UIView alloc] initWithFrame:_label.frame];
        [_labelContainer setClipsToBounds:YES];
        [_labelContainer addSubview:_label];
        
        
        CGRect frame = CGRectMake(0, 0,
                                  _labelContainer.frame.size.width + kStackItemInternMargin + _imageButton.frame.size.width,
                                  MAX(_labelContainer.frame.size.height, _imageButton.frame.size.height));
        [self setFrame:frame];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:self.frame];
        [_button setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [_button addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_button addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
        
        [self addSubview:_labelContainer];
        [self addSubview:_imageButton];
        [self addSubview:_button];
        
        [self setLabelPosition:kStackMenuItemDefaultLabelPosition];
        _isExpanded = YES;
    }
    return self;
}


- (void)dealloc
{
    [_button removeObserver:self forKeyPath:@"highlighted"];
}


#pragma mark - Helpers

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isEqual:_button]) {
        if([keyPath isEqualToString:@"highlighted"]) {
            [_imageButton setHighlighted:[_button isHighlighted]];
        }
    }
}


#pragma mark - Customization

- (void)setLabelPosition:(UPStackMenuItemLabelPosition_e)labelPosition
{
    _labelPosition = labelPosition;
    
    switch (_labelPosition) {
        case UPStackMenuItemLabelPosition_left:
            [_labelContainer setCenter:CGPointMake(_labelContainer.frame.size.width/2, self.frame.size.height/2)];
            [_imageButton setCenter:CGPointMake(self.frame.size.width - _imageButton.frame.size.width/2, self.frame.size.height/2)];
            [_label setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin];
            break;
        case UPStackMenuItemLabelPosition_right:
            [_labelContainer setCenter:CGPointMake(self.frame.size.width - _labelContainer.frame.size.width/2, self.frame.size.height/2)];
            [_imageButton setCenter:CGPointMake(_imageButton.frame.size.width/2, self.frame.size.height/2)];
            [_label setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
            break;
    }
}

- (void)setTitleColor:(UIColor*)color
{
    [_label setTextColor:color];
}


#pragma mark - Accessors

- (CGPoint)itemCenter
{
    return _imageButton.center;
}

- (CGPoint)centerForItemCenter:(CGPoint)itemCenter
{
    return CGPointMake(itemCenter.x - (_imageButton.center.x - self.frame.size.width/2), itemCenter.y);
}


#pragma mark - Interactions

- (void)expandAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration
{
    if(_isExpanded || _isAnimating)
        return;
    
    _isExpanded = YES;
    
    CGRect labelFrame = _labelContainer.frame;
    CGFloat x = 0;
    if(_labelPosition == UPStackMenuItemLabelPosition_right)
        x = self.frame.size.width - _label.frame.size.width;
    labelFrame.origin.x = x;
    labelFrame.size.width = _label.frame.size.width;
    
    if(animated) {
        _isAnimating = YES;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [_labelContainer setFrame:labelFrame];
            [_label setAlpha:1.];
        } completion:^(BOOL finished) {
            _isAnimating = NO;
        }];
    }
    else {
        [_labelContainer setFrame:labelFrame];
        [_label setAlpha:1.];
    }
}

- (void)reduceAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration
{
    if(!_isExpanded || _isAnimating)
        return;
    
    _isExpanded = NO;
    
    CGRect labelFrame = _labelContainer.frame;
    CGFloat x = 0;
    if(_labelPosition == UPStackMenuItemLabelPosition_left)
        x = self.frame.size.width;
    labelFrame.origin.x = x;
    labelFrame.size.width = 0;
    
    if(animated) {
        _isAnimating = YES;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [_labelContainer setFrame:labelFrame];
            [_label setAlpha:0.];
        } completion:^(BOOL finished) {
            _isAnimating = NO;
        }];
    }
    else {
        [_labelContainer setFrame:labelFrame];
        [_label setAlpha:0.];
    }
}


#pragma mark - Actions

- (void)didTouch:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(didTouchStackMenuItem:)])
        [_delegate didTouchStackMenuItem:self];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com