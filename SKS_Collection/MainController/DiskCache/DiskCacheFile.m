//
//  KK_DiskCacheFile.m
//  KsCollection
//
//  Created by KeSen on 16/5/16.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "DiskCacheFile.h"
#import "NSFileManager+File.h"
#import "NSString+Encode.h"

#define kCachePrex @"com.kk.diskCacheFile."
#define kioQueueName kCachePrex"ioSerialQueue."
#define kCacheFoldName kCachePrex"DiskCache"

@interface DiskCacheFile ()
{
    NSCache *_memoryCache;
    NSString *_cacheDirectory;
    dispatch_queue_t _ioSerialQueue;
}
@end

@implementation DiskCacheFile

- (instancetype)init {
    if (self = [super init]) {
        _memoryCache = [[NSCache alloc] init];
        _ioSerialQueue = dispatch_queue_create("com.ks.diskCacheFile.ioSerialQueue", DISPATCH_QUEUE_SERIAL); // DISPATCH_QUEUE_CONCURRENT
        
        [self _createCacheFold];
    }
    return self;
}

- (void)_createCacheFold
{
    [NSFileManager createFoldWithDirectory:kCacheDirectory withFoldName:@"DiskCache" success:^(NSString *newFoldDirectory) {
        self->_cacheDirectory = newFoldDirectory;
        NSLog(@"DiskCacheFile: create fold success");
    } failure:^(NSError *error) {
        NSLog(@"DiskCacheFile: create fold fail");
    }];
}

#pragma mark kvo

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    NSString *encodedKey = [key kk_encodedString];
    [_memoryCache setObject:object forKey:key];
    
    dispatch_async(_ioSerialQueue, ^{
        NSString *filePath = [self->_cacheDirectory stringByAppendingPathComponent:encodedKey];
        BOOL written = [NSKeyedArchiver archiveRootObject:object toFile:filePath];
        if (!written) {
            NSLog(@"NetworkInterface: save respnse object to file failed");
        }
    });
}

- (id)objectForKey:(NSString *)key
{
    NSString *encodedKey = [key kk_encodedString];
    id<NSCoding> object = [_memoryCache objectForKey:encodedKey];
    
    if (!object) {
        NSString *filePath = [_cacheDirectory stringByAppendingPathComponent:encodedKey];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
    }
    
    return object;
}

- (void)removeObjectForKey:(NSString *)key
{
    NSString *encodedKey = [key kk_encodedString];
    [_memoryCache removeObjectForKey:key];
    
    NSString *filePath = [_cacheDirectory stringByAppendingPathComponent:encodedKey];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        if (![fileManager removeItemAtPath:filePath error:&error]) {
            NSLog(@"NetworkInterface: remove item failed with error:%@", error);
        }
    }
}

- (void)removeAllObjects
{
    [_memoryCache removeAllObjects];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager removeItemAtPath:_cacheDirectory error:&error]) {
        NSLog(@"NetworkInterface: remove cache directory failed with error:%@", error);
    }
}

# pragma mark - 触发日期
- (void)_trimToDate:(NSDate *)date
{
    __autoreleasing NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL URLWithString:_cacheDirectory]
                                                   includingPropertiesForKeys:@[NSURLContentModificationDateKey]
                                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                        error:&error];
    if (error) {
        NSLog(@"NetworkInterface: get files error:%@", error);
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    dispatch_async(_ioSerialQueue, ^{
        for (NSURL *fileUrl in files) {
            NSDictionary *dictionary = [fileUrl resourceValuesForKeys:@[NSURLContentModificationDateKey] error:nil];
            NSDate *modificationDate = [dictionary objectForKey:NSURLContentModificationDateKey];
            if (modificationDate.timeIntervalSince1970 - date.timeIntervalSince1970 < 0) {
                [fileManager removeItemAtPath:fileUrl.absoluteString
                                         error:nil];
            }
        }
    });
}

// 删除过期的缓存
- (void)setExpiredTimeInterval:(NSTimeInterval)expiredTimeInterval
{
    _expiredTimeInterval = expiredTimeInterval;
    
    if (expiredTimeInterval > 0) {
        double pastTimeInterval = [[NSDate date] timeIntervalSince1970] - expiredTimeInterval;
        NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970:pastTimeInterval];
        [self _trimToDate:pastDate];
    }
}

@end
