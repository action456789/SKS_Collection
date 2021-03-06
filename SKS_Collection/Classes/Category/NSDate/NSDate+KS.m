//
//  NSDate+KS.m
//  iFanPhoto
//
//  Created by kesen on 14/12/19.
//  Copyright (c) 2014年 柯森. All rights reserved.
//

#import "NSDate+KS.h"
#import <UIKit/UIKit.h>

@implementation NSDate (KS)

/**
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒  
 Z：GMT
 
 yyyy-MM-dd HH:mm:ss.SSS
 yyyy-MM-dd HH:mm:ss
 yyyy-MM-dd
 MM dd yyyy
 
 */


//两个日期进行比较，得到相差的时间
//如:比较 2013-11-17 10:50 与 2013-11-18 00:00:00 相差几天几分几秒
+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to
{
    // 1.日历对象（标识：时区相关的标识）
    NSCalendar *calendar;
    NSUInteger flags;
    
    // 2.合并标记
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {//iOS8
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    }else{
        //忽略deprecated警告
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        #pragma clang diagnostic pop
    }

    // 3.比较
    return [calendar components:flags fromDate:from toDate:to options:0];
}

- (NSDateComponents *)compareDate:(NSDate *)other
{
    return [NSDate compareFrom:self to:other];
}

//使用实例
- (void)eg
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2013-11-17
    NSDate *dealline = [fmt dateFromString:@"2013-11-17"];

    // 2013-11-17 10:50
    NSDate *now = [NSDate date];
    
    NSDateComponents *cmps = [now compareDate:dealline];
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld 天 %ld 小时 %ld 分钟", (long)cmps.day, (long)cmps.hour, (long)cmps.minute];
   
    NSLog(@"%@", timeStr);
}

//删除日期中月和日中前面的0，如2013-01-02返回2013-1-2
+ (NSString *)dateWithNoHead0:(NSDateComponents *)cmps
{
    NSString *day = [NSString stringWithFormat:@"%ld", (long)cmps.day];
    NSString *month = [NSString stringWithFormat:@"%ld", (long)cmps.month];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)cmps.year];
    
    if ([day characterAtIndex:0] == '0') {
        NSRange range = {1, 1};
        day = [day substringWithRange:range];
    }
    if ([month characterAtIndex:0] == '0') {
        NSRange range = {1, 1};
        month = [month substringWithRange:range];
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
}

- (NSString *)dateWithNoHead0:(NSDateComponents *)cmps
{
    return [NSDate dateWithNoHead0:cmps];
}

//使用实例
- (void)eg2{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [[NSDate alloc] init];
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:flags fromDate:date];
    cmps.day = 01;
    cmps.month = 02;
    NSString *str = [NSDate dateWithNoHead0:cmps];
    NSLog(@"date:%@", str);
}
@end
