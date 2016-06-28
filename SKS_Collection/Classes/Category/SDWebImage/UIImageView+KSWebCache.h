//
//  UIImageView+KSWebCache.h
//  图片浏览器示例
//
//  Created by kesen on 14/12/2.
//  Copyright (c) 2014年 KeSen. All rights reserved.
//

#import "UIImageView+WebCache.h"

@interface UIImageView (KSWebCache)

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder;

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;

- (void)clearImageCache;

@end
