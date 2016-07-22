//
//  KK_DiskCache.h
//  KsCollection
//
//  Created by KeSen on 16/4/18.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiskCacheSqlLite : NSObject

@property (nonatomic, assign) BOOL isTableEncrypt;

- (void)dbAddItemWithKey:(NSString *)key value:(id<NSCoding>)object;

- (id<NSCoding>)dbGetItemWithKey:(NSString *)key;

- (void)dbUpdateItemWithKey:(NSString *)key value:(id<NSCoding>)object;

- (void)dbDeleteItemWithKey:(NSString *)key;

@end
