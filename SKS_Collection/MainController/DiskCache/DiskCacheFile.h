//
//  KK_DiskCacheFile.h
//  KsCollection
//
//  Created by KeSen on 16/5/16.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiskCacheFile : NSObject

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

- (id<NSCoding>)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (void)removeAllObjects;

// 缓存存在的时长，如 3 小时 为 expiredTimeInterval = 60 * 60 * 3
@property (nonatomic, assign) NSTimeInterval expiredTimeInterval;

@end
