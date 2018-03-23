//
//  NSArray+URL.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/22.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "NSArray+URL.h"

@implementation NSArray (URL)

// 将数组参数编码为 url 可接受的字符串
// 如 参数为 [1, 2, 3] 转换为 1,2,3
- (NSString *)kk_encodeToURLParaString {
    NSString *str = @"";
    for (int i = 0; i < self.count; i++) {
        NSString *component = [NSString stringWithFormat:@"%@", self[i]];
        str = [str stringByAppendingString:component];
        
        if (i == self.count - 1) {
            break;
        }
        str = [str stringByAppendingString:@","];
    }
    return str;
}

@end

