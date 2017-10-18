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
 Base64 encoded.

 @code
 
 NSString *string = @"我是一只鱼";
 NSString *encodedString = [[string dataUsingEncoding:NSUTF8StringEncoding] kk_base64EncodedString];
 NSLog(@"%@", encodedString);
 
 @endcode
 
 @return base64 encoded String
 */
- (nullable NSString *)kk_base64EncodedString;


/**
 Base64 decode.

 @code
 
 NSData *decodedData = [NSData kk_dataWithBase64EncodedString:encodedString];
 NSString *decodeString = decodedData.kk_utf8String;
 NSLog(@"%@", decodeString);
 
 @endcode
 
 @param base64EncodedString The encoded string.
 @return decoded string
 */
+ (nullable NSData *)kk_dataWithBase64EncodedString:(NSString *_Nonnull)base64EncodedString;

/**
 Returns an NSDictionary or NSArray for decoded self.
 Returns nil if an error occurs.
 */
- (nullable id)kk_jsonValueDecoded;

@end
