//
//  HLAudioPlayer.m
//  音效播放器
//
//  Created by Harvey on 14/6/2.
//  Copyright © 2014年 Haley. All rights reserved.
//

#import "HLAudioPlayer.h"

@implementation HLAudioPlayer

+ (void)initialize
{
    // 音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 设置会话类型
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活会话
    [session setActive:YES error:nil];
}

// 音效Id
static NSMutableDictionary *_soundIDs;

+ (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}


// 所有的播放器
static NSMutableDictionary *_musicPlayers;
+ (NSMutableDictionary *)musicPlayers
{
    if (!_musicPlayers) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}

+ (AVAudioPlayer *)playMusic:(NSString *)fileName
{
    if (!fileName) {
        return nil;
    }
    
    AVAudioPlayer *player = [self musicPlayers][fileName];
    if (!player) {
        NSURL *URL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (!URL) {
            return nil;
        }
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
        
        if (![player prepareToPlay]) {
            return nil;
        }
        
        [self musicPlayers][fileName] = player;
    }
    
    if (!player.isPlaying) {
        [player play];
    }
    
    return player;
}

+ (void)pauseMusic:(NSString *)fileName
{
    if (!fileName) {
        return;
    }
    
    AVAudioPlayer *player = [self musicPlayers][fileName];
    
    [player pause];
}

+ (void)stopMusic:(NSString *)fileName
{
    if (!fileName) {
        return;
    }
    
    AVAudioPlayer *player = [self musicPlayers][fileName];
    
    [player stop];
    
    [[self musicPlayers] removeObjectForKey:fileName];
}

+ (void)playSound:(NSString *)soundName
{
    if (!soundName) {
        return;
    }
    
    SystemSoundID soundID = [[self soundIDs][soundName] unsignedIntValue];
    
    if (!soundID) {
        NSURL *URL = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        if (!URL) {
            return;
        }

        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(URL), &soundID);
        
        [self soundIDs][soundName] = @(soundID);
    }
    
    AudioServicesPlaySystemSound(soundID);
}

+ (void)disposeSound:(NSString *)soundName
{
    if (!soundName) {
        return;
    }
    
    SystemSoundID soundID = [[self soundIDs][soundName] unsignedIntValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [[self soundIDs] removeObjectForKey:soundName];
    }
}

@end
