//
//  NSString+KK_URL.m
//  KsCollection
//
//  Created by KeSen on 16/6/7.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

/**
 *  返回 url 中的参数列表
 */
- (NSDictionary *)parameterInURL:(NSString *)url
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSURLComponents *components = [NSURLComponents componentsWithString:url];
    for(NSURLQueryItem *item in components.queryItems) {
        if (item.name && item.value) {
            [dict setObject:item.value forKey:item.name];
        }
    }
    return dict;
}

@end
