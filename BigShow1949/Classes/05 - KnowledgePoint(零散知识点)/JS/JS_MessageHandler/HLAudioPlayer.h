//
//  HLAudioPlayer.h
//  音效播放器
//
//  Created by Harvey on 14/6/2.
//  Copyright © 2014年 Haley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface HLAudioPlayer : NSObject

+ (AVAudioPlayer *)playMusic:(NSString *)fileName;

+ (void)pauseMusic:(NSString *)fileName;

+ (void)stopMusic:(NSString *)fileName;


+ (void)playSound:(NSString *)soundName;

+ (void)disposeSound:(NSString *)soundName;

@end
