//
//  NSString+YYHash.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYHash)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md2 hash.
 */
- (nullable NSString *)kk_md2String;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (nullable NSString *)kk_md4String;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)kk_md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (nullable NSString *)kk_sha1String;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (nullable NSString *)kk_sha224String;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (nullable NSString *)kk_sha256String;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (nullable NSString *)kk_sha384String;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (nullable NSString *)kk_sha512String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (nullable NSString *)kk_hmacMD5StringWithKey:(NSString *_Nullable)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (nullable NSString *)kk_hmacSHA1StringWithKey:(NSString *_Nullable)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key The hmac key.
 */
- (nullable NSString *)kk_hmacSHA224StringWithKey:(NSString *_Nullable)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (nullable NSString *)kk_hmacSHA256StringWithKey:(NSString *_Nullable)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key The hmac key.
 */
- (nullable NSString *)kk_hmacSHA384StringWithKey:(NSString *_Nullable)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (nullable NSString *)kk_hmacSHA512StringWithKey:(NSString *_Nullable)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (nullable NSString *)kk_crc32String;

@end
