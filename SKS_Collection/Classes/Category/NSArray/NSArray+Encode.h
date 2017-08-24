//
//  NSArray+Encode.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Encode)

/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (nullable NSString *)kk_jsonStringEncoded;

/**
 Convert object to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)kk_jsonPrettyStringEncoded;

@end
