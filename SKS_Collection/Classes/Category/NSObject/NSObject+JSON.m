//
//  NSObject+JSON.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/10/18.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

- (NSString *)kk_jsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

- (NSString *)kk_jsonPrettyString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

- (id)kk_JSONObject {
    NSData *data = nil;
    if ([self isKindOfClass: [NSString class]]) {
        NSString *jsonString = (NSString *)self;
        data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([self isKindOfClass:[NSData class]]) {
        data = (NSData *)self;
    } else {
        NSLog(@"NSObject+JSON: 无法转换");
        return nil;
    }
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    return jsonDict;
}

@end
