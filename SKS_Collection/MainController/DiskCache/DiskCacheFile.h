//
//  KK_DiskCacheFile.h
//  KsCollection
//
//  Created by KeSen on 16/5/16.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiskCacheFile : NSObject

- (void)addItemWithKey:(NSString *)key value:(id<NSCoding>)object;

- (id<NSCoding>)getItemWithKey:(NSString *)key;

- (void)updateItemWithKey:(NSString *)key value:(id<NSCoding>)object;

- (void)deleteItemWithKey:(NSString *)key;

- (void)deleteAllItems;

// 缓存存在的时长，如 3 小时 为 expiredTimeInterval = 60 * 60 * 3
@property (nonatomic, assign) NSTimeInterval expiredTimeInterval;

@end
