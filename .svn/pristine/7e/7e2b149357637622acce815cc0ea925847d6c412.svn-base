//
//  JCFlipPage.m
//  JCFlipPageView
//
//  Created by ThreegeneDev on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCFlipPage.h"

@implementation JCFlipPage
@synthesize reuseIdentifier = _reuseIdentifier;

- (void)dealloc
{
}

- (void)prepareForReuse
{
    
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _reuseIdentifier = reuseIdentifier;
        
#warning ! a temp label
        _tempContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 300.0f)];
        _tempContentLabel.numberOfLines = 1;
        _tempContentLabel.text = @"";
        _tempContentLabel.font = [UIFont systemFontOfSize:200.0f];
        _tempContentLabel.textAlignment = NSTextAlignmentCenter;
        _tempContentLabel.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
        [self addSubview:_tempContentLabel];
        self.backgroundColor = [UIColor lightGrayColor];
        
        _tempContentLabel.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setReuseIdentifier:(NSString *)identifier
{
    _reuseIdentifier = identifier;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
