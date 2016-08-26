//
//  LazyFadeInView.m
//  LazyFadeInView
//
//  Created by Tu You on 14-4-20.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import "LazyFadeInView.h"
#import "LazyFadeInLayer.h"

#define __layer ((LazyFadeInLayer *)self.layer)

@implementation LazyFadeInView

+ (Class)layerClass
{
    return [LazyFadeInLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    __layer.text = text;
}

@end
