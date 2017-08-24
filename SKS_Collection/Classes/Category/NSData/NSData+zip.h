//
//  NSData+zip.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (zip)

#pragma mark - Inflate and deflate
///=============================================================================
/// @name Comperss and Decompress
///=============================================================================

/**
 Decompress data from gzip data.
 @return decompress data.
 */
- (nullable NSData *)kk_gzipDecompress;

/**
 Comperss data to gzip in default compresssion level.
 @return comperss data.
 */
- (nullable NSData *)kk_gzipCompress;

/**
 Decompress data from zlib-compressed data.
 @return decompress data.
 */
- (nullable NSData *)kk_zlibDecompress;

/**
 Comperss data to zlib-compressed in default compresssion level.
 @return comperss data.
 */
- (nullable NSData *)kk_zlibComperss;


@end
