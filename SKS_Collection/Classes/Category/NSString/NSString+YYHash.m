//
//  NSString+YYHash.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSString+YYHash.h"
#import "NSData+YYHash.h"

@implementation NSString (YYHash)

- (NSString *)kk_md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_md2String];
}

- (NSString *)kk_md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_md4String];
}

- (NSString *)kk_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_md5String];
}

- (NSString *)kk_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_sha1String];
}

- (NSString *)kk_sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_sha224String];
}

- (NSString *)kk_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_sha256String];
}

- (NSString *)kk_sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_sha384String];
}

- (NSString *)kk_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_sha512String];
}

- (NSString *)kk_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_hmacMD5StringWithKey:key];
}

- (NSString *)kk_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_hmacSHA1StringWithKey:key];
}

- (NSString *)kk_hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_hmacSHA224StringWithKey:key];
}

- (NSString *)kk_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_hmacSHA256StringWithKey:key];
}

- (NSString *)kk_hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_hmacSHA384StringWithKey:key];
}

- (NSString *)kk_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_hmacSHA512StringWithKey:key];
}

- (NSString *)kk_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_crc32String];
}

@end
