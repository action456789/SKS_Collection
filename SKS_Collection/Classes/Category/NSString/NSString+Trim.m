//
//  NSString+Trim.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString *)kk_stringByTrim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)kk_stringByAppendingNameScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    return [self stringByAppendingFormat:@"@%@x", @(scale)];
}

- (NSString *)kk_stringByAppendingPathScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) return self.copy;
    NSString *ext = self.pathExtension;
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) extRange.location -= 1;
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (BOOL)kk_isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)kk_containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)kk_containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) return NO;
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

@end
