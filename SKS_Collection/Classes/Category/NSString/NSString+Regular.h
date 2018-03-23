//
//  NSString+Regular.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

- (BOOL)kk_isQQ;
- (BOOL)kk_isPhoneNumber;
- (BOOL)kk_isIPAddress;
- (BOOL)kk_isMacAddress;
- (BOOL)kk_isEmail;

// 判断字符串是几位数字，如5位数字 12345, 3为数字012
- (BOOL)kk_isDigitsOfCount:(NSInteger)count;

// 验证是否含有特殊字符
// 只能包含：字母、数字、英文字符
- (BOOL)kk_isNotContainSpecialCharactersAndSpace;

// 验证是否含有特殊字符
// 只能包含：字母、数字、英文字符、空格
- (BOOL)kk_isNotContainSpecialCharacters;

- (NSString *)kk_removeEmoji;

@end
