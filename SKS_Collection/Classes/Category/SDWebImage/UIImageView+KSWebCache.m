//
//  UIImageView+KSWebCache.m
//  图片浏览器示例
//
//  Created by kesen on 14/12/2.
//  Copyright (c) 2014年 KeSen. All rights reserved.
//

#import "UIImageView+KSWebCache.h"

@implementation UIImageView (KSWebCache)

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageLowPriority | SDWebImageRetryFailed completed:completedBlock];
}

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageLowPriority | SDWebImageRetryFailed progress:progressBlock completed:completedBlock];
}

//清除缓存
- (void)clearImageCache
{
    // 1.清除内存中的缓存图片
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 2.取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
