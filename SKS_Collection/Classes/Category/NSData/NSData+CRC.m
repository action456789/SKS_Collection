//
//  NSData+CRC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSData+CRC.h"
#include <zlib.h>

// 循环冗余校验

@implementation NSData (CRC)

- (NSString *)kk_crc32String {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

- (uint32_t)kk_crc32 {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return (uint32_t)result;
}

@end
