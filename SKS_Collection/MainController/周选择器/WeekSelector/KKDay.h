//
//  KKDay.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/11.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, KK_WEEK_DAY) {
    kk_week_sunday = 0,
    kk_week_monday,
    kk_week_tuesday,
    kk_week_wednesday,
    kk_week_thursday,
    kk_week_friday,
    kk_week_saturday,
};

typedef NS_ENUM(NSUInteger, KKDayDescType) {
    KKDayDescTypeCHNormal = 0, // 如 周一 周二 周日，default
    KKDayDescTypeCHShort, // 如 一 二 日
    KKDayDescTypeENNormal, // TODO: 英文，如 Sunday，
    KKDayDescTypeENShort, // TODO: 英文，如 Sun Tue
};

@interface KKDay : NSObject

@property (nonatomic, assign) KK_WEEK_DAY week_day;

+ (instancetype)day:(KK_WEEK_DAY)weekDay;
+ (instancetype)day:(KK_WEEK_DAY)weekDay descType:(KKDayDescType)descType;

- (instancetype)initWithIndex:(NSInteger)index;
- (instancetype)initWithIndex:(NSInteger)index descType:(KKDayDescType)descType;

@end

NS_ASSUME_NONNULL_END
