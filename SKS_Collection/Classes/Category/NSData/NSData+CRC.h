//
//  NSData+CRC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CRC)

/**
 Returns a lowercase NSString for crc32 hash.
 */
- (NSString *)kk_crc32String;

/**
 Returns crc32 hash.
 */
- (uint32_t)kk_crc32;

@end
