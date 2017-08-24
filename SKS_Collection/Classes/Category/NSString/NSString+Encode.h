//
//  NSString+Encode.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

#pragma mark - Encode and decode
///=============================================================================
/// @name Encode and decode
///=============================================================================

/**
 Returns an NSString for base64 encoded.
 */
- (NSString *_Nullable)kk_base64EncodedString;

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *_Nullable)kk_stringByURLEncode;

/**
 URL decode a string in utf-8.
 @return the decoded string.
 */
- (NSString *_Nullable)kk_stringByURLDecode;

/**
 Escape common HTML to Entity.
 Example: "a>b" will be escape to "a&gt;b".
 */
- (NSString *_Nullable)kk_stringByEscapingHTML;


- (NSString *_Nullable)kk_encodedString;

- (NSString *_Nullable)kk_decodedString;

@end
