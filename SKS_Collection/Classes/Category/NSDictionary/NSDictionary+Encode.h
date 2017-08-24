//
//  NSDictionary+Encode.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Encode)

/**
 Convert dictionary to json string. return nil if an error occurs.
 */
- (nullable NSString *)kk_jsonStringEncoded;

/**
 Convert dictionary to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)kk_jsonPrettyStringEncoded;


@end



@interface NSMutableDictionary (Encode)

/**
 Creates and returns a dictionary from a specified property list data.
 
 @param plist   A property list data whose root object is a dictionary.
 @return A new dictionary created from the binary plist data, or nil if an error occurs.
 
 @discussion Apple has implemented this method, but did not make it public.
 */
+ (nullable NSMutableDictionary *)kk_dictionaryWithPlistData:(NSData *_Nullable)plist;

/**
 Creates and returns a dictionary from a specified property list xml string.
 
 @param plist   A property list xml string whose root object is a dictionary.
 @return A new dictionary created from the plist string, or nil if an error occurs.
 */
+ (nullable NSMutableDictionary *)kk_dictionaryWithPlistString:(NSString *)plist;

@end
