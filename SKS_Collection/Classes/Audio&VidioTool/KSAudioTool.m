//  Created by KeSen on 15/9/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  音乐、音效播放

#import "KSAudioTool.h"

@implementation KSAudioTool


/**
 * 如果要允许后台播放，需要进行如下设置：
 *  1. 在 AppDelegate 中，开启后台任务。
     - (void)applicationDidEnterBackground:(UIApplication *)application
     {
         // 开启后台任务
         UIBackgroundTaskIdentifier identifier = [application beginBackgroundTaskWithExpirationHandler:^{
         [application endBackgroundTask:identifier];
         }];
     }
 2. 修改 plist，增加一项：Required background modes 为 audo 播放
 3. 在工具类中设置播放音乐的会话类型为后台播放，第三步在下面的 initialize 方法中实现了。
 */
+ (void)initialize
{
    // 1.创建音频会话
    AVAudioSession *session = [[AVAudioSession alloc] init];
    // 2.设置会话类型
    //   AVAudioSessionCategorySoloAmbient 同时只能播放一个音乐
    [session setCategory:AVAudioSessionCategoryPlayback error:nil]; // 后台播放
    // 3.激活会话
    [session setActive:YES error:nil];
}

static NSMutableDictionary *_soundIDs;

static NSMutableDictionary *_players;

+ (NSMutableDictionary *)soundIDs
{
    if (!_soundIDs) {
        _soundIDs = [NSMutableDictionary dictionary];
    }
    return _soundIDs;
}
+ (NSMutableDictionary *)players
{
    if (!_players) {
        _players = [NSMutableDictionary dictionary];
    }
    return _players;
}

// 播放音效
// 传入需要 播放的音效文件名称
+ (void)playAudioWithFilename:(NSString *)filename
{
    // 0.判断文件名是否为nil
    if (filename == nil) {
        return;
    }
    
    // 1.从字典中取出音效ID
    SystemSoundID soundID = [[self soundIDs][filename] unsignedIntValue];
    
    // 判断音效ID是否为nil
    if (!soundID) {
        // (@"创建新的soundID");
        
        // 音效ID为nil
        // 根据文件名称加载音效URL
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        // 判断url是否为nil
        if (!url) {
            return;
        }
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        // 将音效ID添加到字典中
        [self soundIDs][filename] = @(soundID);
    }
    // 播放音效
    AudioServicesPlaySystemSound(soundID);
}

// 销毁音效
+ (void)disposeAudioWithFilename:(NSString *)filename
{
    // 0.判断文件名是否为nil
    if (filename == nil) {
        return;
    }
    
    // 1.从字典中取出音效ID
    SystemSoundID soundID = [[self soundIDs][filename] unsignedIntValue];
    
    if (soundID) {
        // 2.销毁音效ID
        AudioServicesDisposeSystemSoundID(soundID);
        
        // 3.从字典中移除已经销毁的音效ID
        [[self soundIDs] removeObjectForKey:filename];
    }
  
}

// 根据音乐文件名称播放音乐
+ (AVAudioPlayer *)playMusicWithFilename:(NSString  *)filename
{
    // 0.判断文件名是否为nil
    if (filename == nil) {
        return nil;
    }
    
    // 1.从字典中取出播放器
    AVAudioPlayer *player = [self players][filename];
    
    // 2.判断播放器是否为nil
    if (!player) {
        NSLog(@"创建新的播放器");
        
        // 2.1根据文件名称加载音效URL
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        // 2.2判断url是否为nil
        if (!url) {
            return nil;
        }
        
        // 2.3创建播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 2.4准备播放
        if(![player prepareToPlay])
        {
            return nil;
        }
        // 允许快进
//        player.enableRate = YES;
//        player.rate = 3;
        
        // 2.5将播放器添加到字典中
        [self players][filename] = player;
        
    }
    // 3.播放音乐
    if (!player.playing)
    {
        [player play];
    }
   
    return player;
}

// 根据音乐文件名称暂停音乐
+ (void)pauseMusicWithFilename:(NSString  *)filename
{
    // 0.判断文件名是否为nil
    if (filename == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
    AVAudioPlayer *player = [self players][filename];

    // 2.判断播放器是否存在
    if(player)
    {
        // 2.1判断是否正在播放
        if (player.playing)
        {
            // 暂停
            [player pause];
        }
    }
    
}

// 根据音乐文件名称停止音乐
+ (void)stopMusicWithFilename:(NSString  *)filename
{
    // 0.判断文件名是否为nil
    if (filename == nil) {
        return;
    }
    
    // 1.从字典中取出播放器
    AVAudioPlayer *player = [self players][filename];

    // 2.判断播放器是否为nil
    if (player) {
        // 2.1停止播放
        [player stop];
        // 2.2清空播放器
//        player = nil;
        // 2.3从字典中移除播放器
        [[self players] removeObjectForKey:filename];
    }
}
@end
