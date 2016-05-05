//
//  Created by Alberto Pasca on 27/02/14.
//  Copyright (c) 2014 albertopasca.it. All rights reserved.
//

#import "APRoundedButton.h"
#import <QuartzCore/QuartzCore.h>


@implementation APRoundedButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self makeCorner];
    }
    return self;
}

- (void)awakeFromNib {

    [super awakeFromNib];
    
    [self makeCorner];
}

- (void)makeCorner {
    UIRectCorner corners;
    
    switch ( self.style )
    {
        case 0:
            corners = UIRectCornerBottomLeft;
            break;
        case 1:
            corners = UIRectCornerBottomRight;
            break;
        case 2:
            corners = UIRectCornerTopLeft;
            break;
        case 3:
            corners = UIRectCornerTopRight;
            break;
        case 4:
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case 5:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case 6:
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
            break;
        case 7:
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
            break;
        case 8:
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
            break;
        case 9:
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
            break;
        default:
            corners = UIRectCornerAllCorners;
            break;
    }
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(20.0, 30.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;

}



@end


