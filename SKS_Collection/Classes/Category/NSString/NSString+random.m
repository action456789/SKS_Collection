//
//  NSString+random.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/5/10.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSString+random.h"

@implementation NSString (random)

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *)randomStringWithLength:(int)len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)letters.length)]];
    }
    
    return randomString;
}

@end
