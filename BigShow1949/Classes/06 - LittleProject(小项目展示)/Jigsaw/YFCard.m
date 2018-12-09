//
//  YFCard.m
//  Jigsaw
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YFCard.h"

@implementation YFCard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setDefaultFrame {
    CGRect tempF = self.frame;
    tempF.origin.x = self.position.X * tempF.size.width;
    tempF.origin.y = self.position.Y * tempF.size.height;
    self.frame = tempF;

}

///**
// *  根据position计算位置
// */
//- (void)setPosition:(Position)position {
//
//    _position = position;
//    
//    CGRect tempF = self.frame;
//    tempF.origin.x = position.X * tempF.size.width;
//    tempF.origin.y = position.Y * tempF.size.height;
//    self.frame = tempF;
//}

- (void)moveToTarget:(id)target action:(SEL)action {
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect f = self.frame;
        f.origin.x = self.position.X * self.frame.size.width;
        f.origin.y = self.position.Y * self.frame.size.height;
        self.frame=f;
    } completion:^(BOOL finished) {
        if (target) {
            [target performSelector:action];
        }
    }];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"x:%d, y:%zd", self.position.X, self.position.Y];
}
@end
