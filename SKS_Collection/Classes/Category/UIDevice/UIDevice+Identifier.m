//
//  UIDevice+Identifier.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/5/10.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UIDevice+Identifier.h"

@implementation UIDevice (Identifier)

// 获取app的唯一id
+ (NSString *) identifierForVendor1 {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"";
}

@end
