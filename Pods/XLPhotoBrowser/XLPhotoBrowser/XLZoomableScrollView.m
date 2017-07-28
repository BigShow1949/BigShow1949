//
//  XLZoomableScrollView.m
//  XLPhotoBrowser <https://github.com/xiaoL0204/XLPhotoBrowser>
//
//
//  Created by xiaoL on 16/11/29.
//  Copyright © 2016年 xiaolin. All rights reserved.
//

#import "XLZoomableScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIView+XLExtension.h"

#define XLWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define XLGET_IMAGE(IMAGE_NAME) [UIImage imageNamed:IMAGE_NAME]

#define kMinimumXoomScale 0.95

@interface XLZoomableScrollView() <UIScrollViewDelegate>
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation XLZoomableScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Setup
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.maximumZoomScale = 3;
        self.minimumZoomScale = kMinimumXoomScale;
        self.zoomScale = 1.0;
        self.contentSize = self.frame.size;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.backgroundColor = [UIColor blackColor];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.indicatorView.hidesWhenStopped = YES;
        self.indicatorView.center = self.center;
        [self addSubview:self.indicatorView];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}


-(void)setupImageUrl:(NSString *)imgUrl placeholderImg:(UIImage *)placeholderImg{
    self.minimumZoomScale = kMinimumXoomScale;
    self.zoomScale = self.minimumZoomScale;
    // Reset position
    self.imageView.frame = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    
    self.indicatorView.center = self.center;
    if (imgUrl && [imgUrl isKindOfClass:[NSString class]]) {
        if ([imgUrl hasPrefix:@"http"] || [imgUrl hasPrefix:@"https"]) {
            XLWeakSelf(weakSelf)
            [self.indicatorView startAnimating];
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholderImg completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf.indicatorView stopAnimating];
                
                CGFloat width = image.size.width;
                CGFloat height = image.size.height;
                CGFloat imgRatio = image.size.width/image.size.height;
                CGFloat imgViewRatio = weakSelf.xl_width/weakSelf.xl_height;
                if (imgRatio > imgViewRatio) {  //use width
                    if (width >= weakSelf.xl_width) {
                        CGFloat tempRatio = weakSelf.xl_width/width;
                        width *= tempRatio;
                        height *= tempRatio;
                    }
                }else{  //use height
                    if (height >= weakSelf.xl_height) {
                        CGFloat tempRatio = weakSelf.xl_height/height;
                        width *= tempRatio;
                        height *= tempRatio;
                    }
                }
                
               
                width *= kMinimumXoomScale;
                height *= kMinimumXoomScale;
                
                weakSelf.imageView.xl_size = CGSizeMake(width, height);
                weakSelf.imageView.center = weakSelf.center;
            }];
        }else{
            [self.imageView setImage:XLGET_IMAGE(imgUrl)];
        }
    }
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.imageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(self.imageView.frame, frameToCenter)) self.imageView.frame = frameToCenter;
}


#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - tap action
- (void)handleTapView:(UITapGestureRecognizer *)tapGR{
    if (self.browserDelegate && [self.browserDelegate respondsToSelector:@selector(handleTapPhotoViewWithItem:)]) {
        [self.browserDelegate handleTapPhotoViewWithItem:nil];
    }
}
#pragma mark -

@end
