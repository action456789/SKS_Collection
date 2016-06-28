//
//  KSMovieTool.m
//  KSCollects
//
//  Created by KeSen on 15/11/6.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "KSVedioTool.h"

@interface KSVedioTool ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;


@end

@implementation KSVedioTool

- (MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer) {
        // 负责控制媒体播放的控制器
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:self.movieURL];
        _moviePlayer.view.frame = self.superView.bounds;
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.superView addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

// 传入需要 播放的音效文件名称
+ (void)playVedioWithFilename:(NSString  *)filename {
    
}

// 销毁音效
+ (void)disposeVedioWithFilename:(NSString  *)filename {
    
}

@end
