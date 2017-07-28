//
//  XLPhotoCollectionCell.m
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//  
//
//  Created by xiaoL on 16/11/29.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "XLPhotoCollectionCell.h"
#import "XLZoomableScrollView.h"



@interface XLPhotoCollectionCell() <UIGestureRecognizerDelegate,XLPhotoBrowserTapDelegate>
@property (nonatomic,strong) XLZoomableScrollView *zoomScrollView;
@end

@implementation XLPhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.zoomScrollView = [[XLZoomableScrollView alloc] initWithFrame:self.bounds];
        self.zoomScrollView.browserDelegate = self;
        [self addSubview:self.zoomScrollView];
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.zoomScrollView.frame = self.bounds;
    [self.zoomScrollView setupImageUrl:[self.imageAdapter fetchImageUrl] placeholderImg:nil];
    
    [self.zoomScrollView setNeedsLayout];
    [self.zoomScrollView layoutSubviews];
}


#pragma mark - XLPhotoBrowserTapDelegate
- (void)handleTapPhotoViewWithItem:(id<XLPhotoBrowserAdapterDelegate>)model{
    if (self.delegate && [self.delegate respondsToSelector:@selector(handleTapPhotoViewWithItem:)]) {
        [self.delegate handleTapPhotoViewWithItem:self.imageAdapter];
    }
}
#pragma mark -

@end
