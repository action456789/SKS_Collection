//
//  KKWeek.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "KKWeek.h"
#import "KKDay.h"

@implementation KKWeek

- (NSString *)daysDescription:(NSArray<KKDay *>*)days {
    BOOL isWorkingDay = [[self class] compareDays1:self.workingDay withDays2:days];
    BOOL isWeekend = [[self class] compareDays1:self.weekend withDays2:days];
    BOOL isEveryDay = [[self class] compareDays1:self.aWeek withDays2:days];
    
    NSSet *setAll = [NSSet setWithArray:days];
    NSSet *workingDaySet = [NSSet setWithArray:self.workingDay];
    NSSet *weekendDaySet = [NSSet setWithArray:self.weekend];
    
    if (isWorkingDay) {
        return @"工作日";
    } else if (isWeekend) {
        return @"周末";
    } else if (isEveryDay) {
        return @"每天";
    } else {
        // 工作日+周六、工作日+周日
        if ([workingDaySet isSubsetOfSet:setAll]) {
            for (KKDay *d in self.weekend) {
                if ([setAll containsObject:d]) {
                    return [NSString stringWithFormat:@"工作日、%@", d.description];
                }
            }
        } else if ([weekendDaySet isSubsetOfSet:setAll]) {
            // 周末 + 某几个工作日 如 "周末、周一、周二" 等
            NSString *str = @"周末";
            for (KKDay *d in self.workingDay) {
                if ([setAll containsObject:d]) {
                    str = [NSString stringWithFormat:@"%@、%@", str, d.description];
                }
            }
            return str;
        }
    }
    
    // "周一、周二" 等
    NSString *str = @"";
    for (int i = 0; i < self.aWeek.count; i++) {
        KKDay *d = self.aWeek[i];
        if ([setAll containsObject:d]) {
            if ([str isEqual: @""]) {
                str = [NSString stringWithFormat:@"%@%@", str, d.description];
            } else {
                str = [NSString stringWithFormat:@"%@、%@", str, d.description];
            }
        }
    }
    return str;
}

+ (NSString *)daysDescription:(NSArray<KKDay *>*)days {
    KKWeek *week = [[KKWeek alloc] init];
    return [week daysDescription:days];
}

+ (BOOL)compareDays1:(NSArray<KKDay *> *)days1 withDays2:(NSArray<KKDay *> *)days2 {
    NSSet *set1 = [NSSet setWithArray:days1];
    NSSet *set2 = [NSSet setWithArray:days2];
    
    if ([set1 isEqualToSet:set2]) {
        return YES;
    }
    
    return NO;
}

# pragma - mark getter, setter

// 周一 至 周五
- (NSArray<KKDay *> *)workingDay {
    if (_workingDay == nil) {
        _workingDay = @[[KKDay day:kk_week_monday],
                        [KKDay day:kk_week_tuesday],
                        [KKDay day:kk_week_wednesday],
                        [KKDay day:kk_week_thursday],
                        [KKDay day:kk_week_friday]];
    }
    return _workingDay;
}

// 周六、周日
- (NSArray<KKDay *> *)weekend {
    if (_weekend == nil) {
        _weekend = @[[KKDay day:kk_week_saturday],
                     [KKDay day:kk_week_sunday]];
    }
    return _weekend;
}

// 周一 至 周日
- (NSArray<KKDay *> *)aWeek {
    if (_aWeek == nil) {
        _aWeek = @[[KKDay day:kk_week_sunday],
                   [KKDay day:kk_week_monday],
                   [KKDay day:kk_week_tuesday],
                   [KKDay day:kk_week_wednesday],
                   [KKDay day:kk_week_thursday],
                   [KKDay day:kk_week_friday],
                   [KKDay day:kk_week_saturday]];
    }
    return _aWeek;
}

@end
