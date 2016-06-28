//
//  NSString+Regular.m
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "NSString+KS_Regular.h"

@implementation NSString (KS_Regular)

/**
 *  使用iOS自带函数实现。
 *  复杂功能如富文本可以使用第三方库 RegexKitLite
 */
- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    //    for (NSTextCheckingResult *result in results) {
    //        NSLog(@"%@", NSStringFromRange(result.range));
    //    }
    
    return results.count > 0;
}

- (BOOL)isQQ
{
    // 1.不能以0开头
    // 2.全部是数字
    // 3.5-11位
    return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isPhoneNumber
{
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1[3578]\\d{9}$"];
}

- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}

@end
