//
//  NSDictionary+KS.h
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (KS)

/**
 *  返回 url 中的参数列表
 */
+ (instancetype)ks_dictionaryInURL:(NSString *)url;

/**
 *  JSON 字符串返回字典
 */
+ (instancetype)ks_dictionaryFromString:(NSString *)jsonString;

/**
 *  字典返回json字符串
 */
- (NSString *)ks_jsonString;

@end


@interface NSMutableDictionary (KS)

/**
 Removes and returns the value associated with a given key.
 
 @param aKey The key for which to return and remove the corresponding value.
 @return The value associated with aKey, or nil if no value is associated with aKey.
 */
- (nullable id)kk_popObjectForKey:(id)aKey;

/**
 Returns a new dictionary containing the entries for keys, and remove these
 entries from receiver. If the keys is empty or nil, it just returns an
 empty dictionary.
 
 @param keys The keys.
 @return The entries for the keys.
 */
- (NSDictionary *)kk_popEntriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
