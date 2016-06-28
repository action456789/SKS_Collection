//
//  KK_DiskCacheFile.m
//  KsCollection
//
//  Created by KeSen on 16/5/16.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KK_DiskCacheFile.h"
#import "NSString+KK_File.h"

typedef NS_ENUM(NSInteger, KK_CacheFor) {
    KK_CacheForObject,
    KK_CacheForImage,
    KK_CacheForVoice
};

#define KK_cachePrex @"com.kk.diskCacheFile."
#define KK_ioQueueName KK_cachePrex"ioSerialQueue."
#define KK_cacheFoldName KK_cachePrex"DiskCache"

@interface KK_DiskCacheFile ()
{
    NSFileManager *_fileManager;
    dispatch_queue_t _ioSerialQueue;
}
@end

@implementation KK_DiskCacheFile

- (instancetype)init {
    if (self = [super init]) {
        _ioSerialQueue = dispatch_queue_create([KK_ioQueueName cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
        [KK_cacheFoldName createFoldInSanbox:KK_SandBoxCaches Success:nil failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    return self;
}


// TODO
@end
