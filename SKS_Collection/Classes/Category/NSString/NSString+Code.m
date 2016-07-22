//
//  NSString+Code.m
//  SKS_Collection
//
//  Created by KeSen on 7/22/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "NSString+Code.h"

@implementation NSString (Code)

- (NSString *)encodedString
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

- (NSString *)decodedString
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
