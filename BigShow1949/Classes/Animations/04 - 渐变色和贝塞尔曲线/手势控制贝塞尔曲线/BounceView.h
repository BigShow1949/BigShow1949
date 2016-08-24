//
//  BounceView.h
//  KYBezierBounceView
//
//  Created by Kitten Yang on 2/17/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BounceView : UIView

@property(nonatomic,strong)CAShapeLayer * verticalLineLayer;
@property(nonatomic,strong)UIPanGestureRecognizer *sgr;

@end
