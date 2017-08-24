//
//  NSString+Regular.m
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "NSString+Regular.h"

@implementation NSString (Regular)

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

/*
 移动号段
 134 135 136 137 138 139 147 150 151 152 157 158 159 172 178 182 183 184 187 188
 
 联通号段：
 130 131 132 145 155 156 171 175 176 185 186
 
 电信号段：
 133 149 153 173 177 180 181 189
 
 虚拟运营商:
 170
 
 */
- (BOOL)isPhoneNumber
{
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1[34578]\\d{9}$"];
}

- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"([0-9]{1,3}\\.){3}[0-9]{1,3}"];
}

// 判断字符串是几位数字，如5位数字 12345, 3为数字012
- (BOOL)isDigitsOfCount:(NSInteger)count {
    NSString *regex = [NSString stringWithFormat:@"^\\d{%ld}$", (long)count];
    return [self match:regex];
}

- (BOOL)isEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self match:regex];
}

// 检验 mac 地址
// 00-24-21-19-BD-E4
// 00:24:21:19:BD:E4
- (BOOL)isMacAddress
{
    NSString *regex = @"([A-Fa-f0-9]{2}[:-]){5}[A-Fa-f0-9]{2}";
    return [self match:regex];
}

@end
