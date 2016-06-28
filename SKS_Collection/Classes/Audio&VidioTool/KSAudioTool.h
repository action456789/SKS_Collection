//  Created by KeSen on 15/9/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface KSAudioTool : NSObject


// 播放音效
// 传入需要 播放的音效文件名称
+ (void)playAudioWithFilename:(NSString  *)filename;

// 销毁音效
+ (void)disposeAudioWithFilename:(NSString  *)filename;

// 根据音乐文件名称播放音乐
+ (AVAudioPlayer *)playMusicWithFilename:(NSString  *)filename;

// 根据音乐文件名称暂停音乐
+ (void)pauseMusicWithFilename:(NSString  *)filename;

// 根据音乐文件名称停止音乐
+ (void)stopMusicWithFilename:(NSString  *)filename;
@end
