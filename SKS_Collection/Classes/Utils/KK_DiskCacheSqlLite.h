//
//  KK_DiskCache.h
//  KsCollection
//
//  Created by KeSen on 16/4/18.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KK_DiskCacheSqlLite : NSObject

- (BOOL)dbSaveItemWithKey:(NSString *)key value:(NSData *)value;

- (NSData *)dbGetItemWithKey:(NSString *)key;

- (BOOL)dbUpdateItemWithKey:(NSString *)key value:(NSData *)data;

- (BOOL)dbDeleteItemWithKey:(NSString *)key;

- (NSDictionary *)dbAllKeysAndValues;

@end
