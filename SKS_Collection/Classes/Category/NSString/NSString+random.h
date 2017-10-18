//
//  NSString+random.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/5/10.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (random)


/**
 返回len位随机字符

 @param len 产生的随机字符位数
 @return 随机字符串
 */
+ (NSString *)randomStringWithLength:(int)len;

@end
