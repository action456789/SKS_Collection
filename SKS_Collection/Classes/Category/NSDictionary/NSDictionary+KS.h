//
//  NSDictionary+KS.h
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KS)

/**
 *  返回 url 中的参数列表
 */
+ (instancetype)dictionaryInURL:(NSString *)url;

/**
 *  JSON 字符串返回字典
 */
+ (instancetype)dictionaryFromString:(NSString *)JSONString;

@end
