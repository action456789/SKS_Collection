//
//  NSData+Encode.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encode)

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)kk_utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)kk_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (nullable NSData *)kk_dataWithHexString:(NSString *_Nullable)hexString;


/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)kk_base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)kk_jsonValueDecoded;

@end
