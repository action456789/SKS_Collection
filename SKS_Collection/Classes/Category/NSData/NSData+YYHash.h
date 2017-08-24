//
//  NSData+Hash.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YYHash)

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)kk_md2String;

/**
 Returns an NSData for md2 hash.
 */
- (NSData *)kk_md2Data;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)kk_md4String;

/**
 Returns an NSData for md4 hash.
 */
- (NSData *)kk_md4Data;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)kk_md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)kk_md5Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)kk_sha1String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)kk_sha1Data;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)kk_sha224String;

/**
 Returns an NSData for sha224 hash.
 */
- (NSData *)kk_sha224Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)kk_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)kk_sha256Data;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)kk_sha384String;

/**
 Returns an NSData for sha384 hash.
 */
- (NSData *)kk_sha384Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)kk_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)kk_sha512Data;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)kk_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSData *)kk_hmacMD5DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)kk_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)kk_hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSString *)kk_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSData *)kk_hmacSHA224DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSString *)kk_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSData *)kk_hmacSHA256DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSString *)kk_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSData *)kk_hmacSHA384DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSString *)kk_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSData *)kk_hmacSHA512DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)kk_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)kk_crc32;

@end
