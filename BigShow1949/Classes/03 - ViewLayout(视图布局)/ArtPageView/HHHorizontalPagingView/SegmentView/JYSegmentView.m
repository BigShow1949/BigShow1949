//
//  JYSegmentView.m
//  Demo
//
//  Created by weijingyun on 2017/8/29.
//  Copyright © 2017年 weijingyun. All rights reserved.
//

#import "JYSegmentView.h"

@interface JYSegmentView ()

@property (nonatomic, strong) NSMutableArray     *segmentButtonConstraintArray;

@end

@implementation JYSegmentView

- (void)setSegmentButtonSize:(CGSize)segmentButtonSize {
    _segmentButtonSize = segmentButtonSize;
    [self configureSegmentButtonLayout];
}

- (void)configureSegmentButtonLayout {
    
    if([self.segmentButtons count] > 0) {
        
        CGFloat buttonTop    = 0.f;
        CGFloat buttonLeft   = 0.f;
        CGFloat buttonWidth  = 0.f;
        CGFloat buttonHeight = 0.f;
        if(CGSizeEqualToSize(self.segmentButtonSize, CGSizeZero)) {
            buttonWidth = [[UIScreen mainScreen] bounds].size.width/(CGFloat)[self.segmentButtons count];
            buttonHeight = self.segmentBarHeight;
        }else {
            buttonWidth = self.segmentButtonSize.width;
            buttonHeight = self.segmentButtonSize.height;
            buttonTop = (self.segmentBarHeight - buttonHeight)/2.f;
            buttonLeft = ([[UIScreen mainScreen] bounds].size.width - ((CGFloat)[self.segmentButtons count]*buttonWidth))/((CGFloat)[self.segmentButtons count]+1);
        }
        
        [self removeConstraints:self.segmentButtonConstraintArray];
        for(int i = 0; i < [self.segmentButtons count]; i++) {
            UIButton *segmentButton = self.segmentButtons[i];
            [segmentButton removeConstraints:self.segmentButtonConstraintArray];
            segmentButton.tag = pagingSubViewTag+i;
            [segmentButton addTarget:self action:@selector(segmentButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:segmentButton];
            
            if(i == 0) {
                [segmentButton setSelected:YES];
                self.currenPage = 0;
            }
            
            segmentButton.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:buttonTop];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:i*buttonWidth+buttonLeft*i+buttonLeft];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:buttonWidth];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:segmentButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:buttonHeight];
            
            [self.segmentButtonConstraintArray addObject:topConstraint];
            [self.segmentButtonConstraintArray addObject:leftConstraint];
            [self.segmentButtonConstraintArray addObject:widthConstraint];
            [self.segmentButtonConstraintArray addObject:heightConstraint];
            
            [self addConstraint:topConstraint];
            [self addConstraint:leftConstraint];
            [segmentButton addConstraint:widthConstraint];
            [segmentButton addConstraint:heightConstraint];
            
            if (segmentButton.currentImage) {
                CGFloat imageWidth = segmentButton.imageView.bounds.size.width;
                CGFloat labelWidth = segmentButton.titleLabel.bounds.size.width;
                segmentButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + 5, 0, -labelWidth);
                segmentButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
            }
        }
        
    }
}

- (void)segmentButtonEvent:(UIButton *)segmentButton {
    if (self.clickBlock) {
        self.clickBlock(segmentButton);
    }
}

- (void)setSelectedPage:(NSInteger)selectedPage {
    
    for(UIButton *b in self.segmentButtons) {
        if(b.tag - pagingSubViewTag == selectedPage) {
            [b setSelected:YES];
        }else {
            [b setSelected:NO];
        }
    }
    self.currenSelectedPage = selectedPage;
}

- (BOOL)findSubSegmentView:(UIView *)view {
    
    __block BOOL find = NO;
    [self.segmentButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj == view) {
            find = YES;
            *stop = YES;
        }
    }];
    return find;
}

@end
