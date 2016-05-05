//
//  ZTypewriteEffectLabel.m
//  ZTypewriteEffect
//
//  Created by mapboo on 7/27/14.
//  Copyright (c) 2014 mapboo. All rights reserved.
//

#import "ZTypewriteEffectLabel.h"

@implementation ZTypewriteEffectLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hasSound = YES;
        self.typewriteTimeInterval = 0.3;
    }
    return self;
}

-(void)startTypewrite
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"typewriter" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    
    [NSTimer scheduledTimerWithTimeInterval:self.typewriteTimeInterval target:self selector:@selector(outPutWord:) userInfo:nil repeats:YES];
}

-(void)outPutWord:(id)atimer
{
    if (self.text.length == self.currentIndex) {
       [atimer invalidate];
        atimer = nil;
        self.typewriteEffectBlock();
    }else{
        self.currentIndex++;
        NSDictionary *dic = @{NSForegroundColorAttributeName: self.typewriteEffectColor};
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutStr addAttributes:dic range:NSMakeRange(0, self.currentIndex)];
        [self setAttributedText:mutStr];
        
        self.hasSound? AudioServicesPlaySystemSound (soundID):AudioServicesPlaySystemSound (0);
    }
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
