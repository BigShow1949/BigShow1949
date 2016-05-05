//
//  --------------------------------------------
//  Copyright (C) 2011 by Simon Blommegård
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  --------------------------------------------
//
//  SBGradientOverlayLayer.m
//  SBTickerView
//
//  Created by Simon Blommegård on 2011-12-10.
//  Copyright 2011 Simon Blommegård. All rights reserved.
//

#import "SBGradientOverlayLayer.h"

@interface SBGradientOverlayLayer ()
@property (nonatomic, assign) CGFloat minimumOpacity;
@property (nonatomic, assign) CGFloat maximumOpacity;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CALayer *gradientMaskLayer;
@end

@implementation SBGradientOverlayLayer

@synthesize type = _type;
@synthesize segment = _segment;
@dynamic gradientOpacity;

@synthesize minimumOpacity = _minimumOpacity;
@synthesize maximumOpacity = _maximumOpacity;
@synthesize gradientLayer = _gradientLayer;
@synthesize gradientMaskLayer = _gradientMaskLayer;

- (id)initWithStyle:(SBGradientOverlayLayerType)type segment:(SBGradientOverlayLayerSegment)segment {
	if ((self = [super init])) {
        _type = type;
        _segment = segment;
		
        [self setMasksToBounds:YES];
		[self addSublayer:self.gradientLayer];
        [self setContentsScale:[[UIScreen mainScreen] scale]];
		
        _minimumOpacity = 0.;
        
        [self setGradientMaskLayer:[CALayer layer]];
        [_gradientMaskLayer setContentsScale:[[UIScreen mainScreen] scale]];
        [_gradientLayer setMask:_gradientMaskLayer];
        
		if (type == SBGradientOverlayLayerTypeFace) {
			[_gradientLayer setColors:[NSArray arrayWithObjects:
                                       (__bridge id)[UIColor colorWithWhite:0. alpha:.5].CGColor,
                                       (__bridge id)[UIColor colorWithWhite:0. alpha:1.].CGColor,
                                       nil]];
            
			[_gradientLayer setLocations:[NSArray arrayWithObjects:
                                          [NSNumber numberWithFloat:0.],
                                          [NSNumber numberWithFloat:1.],
                                          nil]];
			
			_maximumOpacity = .65;
		} else {
			[_gradientLayer setColors:[NSArray arrayWithObjects:
									 (__bridge id)[UIColor colorWithWhite:0. alpha:0.].CGColor,
									 (__bridge id)[UIColor colorWithWhite:0. alpha:.5].CGColor,
									 (__bridge id)[UIColor colorWithWhite:0. alpha:1.].CGColor,
									 nil]];
            
			[_gradientLayer setLocations:[NSArray arrayWithObjects:
										[NSNumber numberWithFloat:.2],
										[NSNumber numberWithFloat:.4],
										[NSNumber numberWithFloat:1.],
										nil]];
			

			_maximumOpacity = 0.95;
		}
        
        if (segment == SBGradientOverlayLayerSegmentTop) {
            [self setContentsGravity:kCAGravityBottom];
            
            [_gradientLayer setStartPoint:CGPointMake(0., 0.)];
            [_gradientLayer setEndPoint:CGPointMake(0., 1.)];
            
            [_gradientMaskLayer setContentsGravity:kCAGravityBottom];
        } else {
            [self setContentsGravity:kCAGravityTop];
            
            [_gradientLayer setStartPoint:CGPointMake(0., 1.)];
            [_gradientLayer setEndPoint:CGPointMake(0., 0.)];
            
            [_gradientMaskLayer setContentsGravity:kCAGravityTop];
        }
        
		[_gradientLayer setOpacity:_minimumOpacity];
        

	}
	return self;
}

- (void)layoutSublayers {
	[super layoutSublayers];
	[_gradientLayer setFrame:self.bounds];
    [_gradientMaskLayer setFrame:self.bounds];
}

#pragma mark - Properties

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc] init];
        [_gradientLayer setFrame:self.bounds];
    }
    return _gradientLayer;
}

- (CGFloat)gradientOpacity {
	return _gradientLayer.opacity;
}


- (void)setGradientOpacity:(CGFloat)opacity {
    
    // 翻页超过中线后才开始阴影变化。
    if (opacity > 0.5f)
    {
        opacity -= 0.5f;
        opacity *= 2.5f;
    }
    else
    {
        opacity = 0.0f;
    }
    
    [_gradientLayer setOpacity:(opacity * (_maximumOpacity - _minimumOpacity) + _minimumOpacity)];
}

- (void)setContents:(id)contents {
    [super setContents:contents];
    
    [_gradientMaskLayer setContents:contents];
}

@end
