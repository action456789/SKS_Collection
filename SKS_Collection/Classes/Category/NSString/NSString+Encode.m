//
//  NSString+Encode.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSString+Encode.h"
#import "NSData+Encode.h"

@implementation NSString (Encode)

- (NSString *)kk_base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] kk_base64EncodedString];
}

- (NSString *)kk_encodedString
{
    if (!self.length) {
        return @"";
    }
    
    CFStringRef static const charsToEscape = CFSTR(",:/");
    CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                        (__bridge CFStringRef)self,
                                                                        NULL,
                                                                        charsToEscape,
                                                                        kCFStringEncodingUTF8);
    
    return (__bridge_transfer NSString *)escapedString;
}

- (NSString *)kk_decodedString
{
    if (!self.length) {
        return @"";
    }
    
    CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    return (__bridge_transfer NSString *)unescapedString;
}

@end
