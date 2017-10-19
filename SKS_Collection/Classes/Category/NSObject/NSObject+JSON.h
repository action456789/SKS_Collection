//
//  NSObject+JSON.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/10/18.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

/**
 字典/数组 -> JSON 字符串
 return nil if an error occurs.
 */
- (NSString *)kk_jsonString;

/**
 字典/数组 -> JSON 字符串
 Convert dictionary to json string formatted. return nil if an error occurs.
 */
- (NSString *)kk_jsonPrettyString;

/**
 JSON 字符串/JSON Data -> 字典/数组

 @return 对象
 */
- (id)kk_JSONObject;

@end
