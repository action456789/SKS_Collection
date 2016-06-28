//
//  KSMovieTool.h
//  KSCollects
//
//  Created by KeSen on 15/11/6.
//  Copyright © 2015年 KeSen. All rights reserved.
//  视频播放

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface KSVedioTool : NSObject

// 传入需要播放的视屏文件 URL
@property (nonatomic, strong) NSURL  *movieURL;

@property (nonatomic, strong) UIView *superView;

// 传入需要播放的视屏文件名称
+ (void)playVedioWithFilename:(NSString  *)filename;

// 销毁音效
+ (void)disposeVedioWithFilename:(NSString  *)filename;



@end
