//
//  KKDay.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/11.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "KKDay.h"

@implementation KKDay

- (instancetype)initWithDay:(KK_WEEK_DAY)weekDay
{
    self = [super init];
    if (self) {
        self.week_day = weekDay;
    }
    return self;
}

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        self.week_day = index;
    }
    return self;
}

+ (instancetype)day:(KK_WEEK_DAY)weekDay {
    KKDay *day = [[KKDay alloc] initWithDay:weekDay];
    return day;
}

- (NSString *)description {
    NSString *desc = @"";
    switch (self.week_day) {
        case kk_week_monday:
            desc = @"周一";
            break;
        case kk_week_tuesday:
            desc = @"周二";
            break;
        case kk_week_wednesday:
            desc = @"周三";
            break;
        case kk_week_thursday:
            desc = @"周四";
            break;
        case kk_week_friday:
            desc = @"周五";
            break;
        case kk_week_saturday:
            desc = @"周六";
            break;
        case kk_week_sunday:
            desc = @"周日";
            break;
    }
    return desc;
}

- (BOOL)isEqual:(id)object {
    if (self == object) { return YES; }
    
    if (![object isKindOfClass:[KKDay class]]) {return NO;}
    
    return [self isEqualToDay:(KKDay *)object];
}

- (BOOL)isEqualToDay:(KKDay *)day {
    if (!day) {return NO;}
    
    BOOL haveEqualDay = self.week_day == day.week_day;
    
    return haveEqualDay;
}

- (NSUInteger)hash {
    NSUInteger hash = [@(self.week_day) hash];
    //    NSLog(@"hash = %ld", (unsigned long)hash);
    return hash;
}

@end
