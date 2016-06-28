//
//  NSDate+KS.h
//  iFanPhoto
//
//  Created by kesen on 14/12/19.
//  Copyright (c) 2014年 柯森. All rights reserved.
//  日期操作

#import <Foundation/Foundation.h>

@interface NSDate (KS)

//两个日期进行比较，得到相差的时间
+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to;
- (NSDateComponents *)compareDate:(NSDate *)other;

//删除日期中月和日中前面的0，如2013-01-02返回2013-1-2
+ (NSString *)dateWithNoHead0:(NSDateComponents *)cmps;
- (NSString *)dateWithNoHead0:(NSDateComponents *)cmps;

@end
