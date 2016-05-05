//
//  ZYQSphereView.m
//  SphereViewSample
//
//  Created by Zhao Yiqi on 13-12-8.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "ZYQSphereView.h"
#import "PFGoldenSectionSpiral.h"
#import <QuartzCore/QuartzCore.h>

@interface ZYQSphereView(Private)
- (CGFloat)coordinateForNormalizedValue:(CGFloat)normalizedValue withinRangeOffset:(CGFloat)rangeOffset;
- (void)rotateSphereByAngle:(CGFloat)angle fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;
- (void)layoutViews;
- (void)layoutView:(UIView *)view withPoint:(PFPoint)point;
@end

@interface ZYQSphereView (){
    float intervalX;
    float intervalY;
}

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ZYQSphereView

-(BOOL)isTimerStart{
    return [_timer isValid];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
		panRecognizer.minimumNumberOfTouches = 1;
		[self addGestureRecognizer:panRecognizer];
		[panRecognizer release];
		
		UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
		[self addGestureRecognizer:pinchRecognizer];
		[pinchRecognizer release];
		
		UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationGesture:)];
		[self addGestureRecognizer:rotationRecognizer];
		[rotationRecognizer release];
		
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
		tapRecognizer.numberOfTapsRequired = 1;
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        intervalX=1;
    }
    return self;
}

-(void)changeView{
    CGPoint normalPoint=self.frame.origin;
    CGPoint movePoint=CGPointMake(self.frame.origin.x+intervalX, self.frame.origin.y+intervalY);
    
    [self rotateSphereByAngle:1 fromPoint:normalPoint toPoint:movePoint];
}

-(void)timerStart{
    if (_timer.isValid) {
        [_timer invalidate];
    }
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
}

-(void)timerStop{
    if (_timer.isValid) {
        [_timer invalidate];
    }
}

- (void)setItems:(NSArray *)items {
	[pointMap release];
	pointMap = [[NSMutableDictionary alloc] init];
	
	NSArray *spherePoints = [PFGoldenSectionSpiral sphere:items.count];
	for (int i=0; i<items.count; i++) {
		PFPoint point;
		NSValue *pointRep = [spherePoints objectAtIndex:i];
		[pointRep getValue:&point];
		
		UIView *view = [items objectAtIndex:i];
		view.tag = i;
		[self layoutView:view withPoint:point];
		[self addSubview:view];
				
		[pointMap setObject:pointRep forKey:[NSNumber numberWithInt:i]];
	}
	
	[self rotateSphereByAngle:1 fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, 1)];
}

- (void)setFrame:(CGRect)pFrame {
	[super setFrame:pFrame];
	
	originalSphereViewBounds = self.bounds;
}



#pragma mark -
#pragma mark UIGestureRecognizer methods

- (void)handlePanGesture:(UIPanGestureRecognizer *)panRecognizer {
	switch (panRecognizer.state) {
		case UIGestureRecognizerStateBegan:
			originalLocationInView = [panRecognizer locationInView:self];
			previousLocationInView = originalLocationInView;
			break;
		case UIGestureRecognizerStateChanged: {
			CGPoint touchPoint = [panRecognizer locationInView:self];
			
			CGPoint normalizedTouchPoint = CGPointMakeNormalizedPoint(touchPoint, self.frame.size.width);
			CGPoint normalizedPreviousTouchPoint = CGPointMakeNormalizedPoint(previousLocationInView, self.frame.size.width);
			CGPoint normalizedOriginalTouchPoint = CGPointMakeNormalizedPoint(originalLocationInView, self.frame.size.width);
			
            // Touch direction handling
			PFAxisDirection xAxisDirection = PFDirectionMakeXAxisSensitive(normalizedPreviousTouchPoint, normalizedTouchPoint);
			if (xAxisDirection != lastXAxisDirection && xAxisDirection != PFAxisDirectionNone) {
				lastXAxisDirection = xAxisDirection;
				
				originalLocationInView = CGPointMake(touchPoint.x, previousLocationInView.y);
			}
			
			PFAxisDirection yAxisDirection = PFDirectionMakeYAxisSensitive(normalizedPreviousTouchPoint, normalizedTouchPoint);
			if (yAxisDirection != lastYAxisDirection && yAxisDirection != PFAxisDirectionNone) {
				lastYAxisDirection = yAxisDirection;
				
				originalLocationInView = CGPointMake(previousLocationInView.x, touchPoint.y);
			}
			
			previousLocationInView = touchPoint;
			
            intervalX=normalizedTouchPoint.x<normalizedOriginalTouchPoint.x?-1:1;
            intervalY=normalizedTouchPoint.y<normalizedOriginalTouchPoint.y?-1:1;

			// Sphere rotation
			[self rotateSphereByAngle:1 fromPoint:normalizedOriginalTouchPoint toPoint:normalizedTouchPoint];
		}
			
			break;
		default:
			break;
	}
    if (_isPanTimerStart) {
        [self timerStart];
    }

}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)pinchRecognizer {
	static CGRect InitialSphereViewBounds;
	
	UIView *view = pinchRecognizer.view;
	
	if (pinchRecognizer.state == UIGestureRecognizerStateBegan){
		InitialSphereViewBounds = view.bounds;
	}
	
	CGFloat factor = pinchRecognizer.scale;
	
	CGAffineTransform scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, factor, factor);
	
	CGRect sphereFrame = CGRectApplyAffineTransform(InitialSphereViewBounds, scaleTransform);
	CGRect screenFrame = [UIScreen mainScreen].bounds;
	
	if ((sphereFrame.size.width > screenFrame.size.width 
		&& sphereFrame.size.height > screenFrame.size.height)
		|| (sphereFrame.size.width < originalSphereViewBounds.size.width 
			&& sphereFrame.size.height < originalSphereViewBounds.size.height)) {
		return;
	}
	
	view.bounds = sphereFrame;
	
    
	[self layoutViews];
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)rotationRecognizer {
	static CGFloat LastSphereRotationAngle;
	
	if (rotationRecognizer.state == UIGestureRecognizerStateEnded) {
		LastSphereRotationAngle = 0;
		return;
	}
	
	PFAxisDirection rotationDirection;
	
	CGFloat rotation = rotationRecognizer.rotation;
	
	if (rotation > LastSphereRotationAngle) {
		rotationDirection = PFAxisDirectionPositive;
	} else if (rotation < LastSphereRotationAngle) {
		rotationDirection = PFAxisDirectionNegative;
	}
		
	rotation = fabs(rotation) * rotationDirection;
	
	NSArray *subviews = self.subviews;
	for (int i=0; i<subviews.count; i++) {
		UIView *view = [subviews objectAtIndex:i];
		
		NSNumber *key = [NSNumber numberWithInt:i];
		
		PFPoint point;
		
		NSValue *pointRep = [pointMap objectForKey:key];
		[pointRep getValue:&point];
		
		PFPoint aroundPoint = PFPointMake(0, 0, 0);
		PFMatrix coordinate = PFMatrixTransform3DMakeFromPFPoint(point);

		PFMatrix transform = PFMatrixTransform3DMakeZRotationOnPoint(aroundPoint, rotation);
		
		point = PFPointMakeFromMatrix(PFMatrixMultiply(coordinate, transform)); 
		
		[pointMap setObject:[NSValue value:&point withObjCType:@encode(PFPoint)] forKey:key];
		
		[self layoutView:view withPoint:point];
	}
	
	LastSphereRotationAngle = rotationRecognizer.rotation;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapRecognizer {
    if ([self isTimerStart]) {
        [self timerStop];
    }
    else{
        [self timerStart];
    }
}


#pragma mark -
#pragma mark Animation methods

- (void)rotateSphereByAngle:(CGFloat)angle fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
	NSArray *subviews = self.subviews;
	for (int i=0; i<subviews.count; i++) {
		UIView *view = [subviews objectAtIndex:i];
		
		NSNumber *key = [NSNumber numberWithInt:i];
		
		PFPoint point;
		
		NSValue *pointRep = [pointMap objectForKey:key];
		[pointRep getValue:&point];
		
		PFPoint aroundPoint = PFPointMake(0, 0, 0);
		PFMatrix coordinate = PFMatrixTransform3DMakeFromPFPoint(point);
		
		PFMatrix transform = PFMatrixMakeIdentity(4,4);
		PFAxisDirection xAxisDirection = PFDirectionMakeXAxis(fromPoint, toPoint);
		if (xAxisDirection != PFAxisDirectionNone) {
			transform = PFMatrixMultiply(transform, PFMatrixTransform3DMakeYRotationOnPoint(aroundPoint,xAxisDirection * -angle));
		}
		
		PFAxisDirection yAxisDirection = PFDirectionMakeYAxis(fromPoint, toPoint);
		if (yAxisDirection != PFAxisDirectionNone) {
			transform = PFMatrixMultiply(transform, PFMatrixTransform3DMakeXRotationOnPoint(aroundPoint,yAxisDirection * angle));
		}
		
		point = PFPointMakeFromMatrix(PFMatrixMultiply(coordinate, transform)); 
		
		[pointMap setObject:[NSValue value:&point withObjCType:@encode(PFPoint)] forKey:key];
		
		[self layoutView:view withPoint:point];
	}
}

- (CGFloat)coordinateForNormalizedValue:(CGFloat)normalizedValue withinRangeOffset:(CGFloat)rangeOffset {
	CGFloat half = rangeOffset / 2.f;
	CGFloat coordinate = fabs(normalizedValue) * half;
	if (normalizedValue > 0) {
		coordinate += half;
	} else {
		coordinate = half - coordinate;
	}
	return coordinate;
}

- (void)layoutView:(UIView *)view withPoint:(PFPoint)point {
	CGFloat viewSize = view.frame.size.width;
	
	CGFloat width = self.frame.size.width - viewSize*2;
	CGFloat x = [self coordinateForNormalizedValue:point.x withinRangeOffset:width];
	CGFloat y = [self coordinateForNormalizedValue:point.y withinRangeOffset:width];
	view.center = CGPointMake(x + viewSize, y + viewSize);
	
	CGFloat z = [self coordinateForNormalizedValue:point.z withinRangeOffset:1];
	
	view.transform = CGAffineTransformScale(CGAffineTransformIdentity, z, z);
	view.layer.zPosition = z;
}

- (void)layoutViews {
	NSArray *subviews = self.subviews;
	for (int i=0; i<subviews.count; i++) {
		UIView *view = [subviews objectAtIndex:i];
		
		NSNumber *key = [NSNumber numberWithInt:i];
		
		PFPoint point;
		
		NSValue *pointRep = [pointMap objectForKey:key];
		[pointRep getValue:&point];
		
		[self layoutView:view withPoint:point];
	}		
}

- (void)dealloc {
	[pointMap release];
    if ([_timer isValid]) {
        [_timer invalidate];
    }
	[_timer release];
    
    [super dealloc];
}


@end
