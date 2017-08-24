//
//  NSDate+Component.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Component)

#pragma mark - Component Properties
///=============================================================================
/// @name Component Properties
///=============================================================================

@property (nonatomic, readonly) NSInteger kk_year; ///< Year component
@property (nonatomic, readonly) NSInteger kk_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger kk_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger kk_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger kk_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger kk_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger kk_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger kk_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger kk_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger kk_weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger kk_weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger kk_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger kk_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL kk_isLeapMonth; ///< whether the month is leap month 闰月
@property (nonatomic, readonly) BOOL kk_isLeapYear; ///< whether the year is leap year 闰年
@property (nonatomic, readonly) BOOL kk_isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL kk_isYesterday; ///< whether date is yesterday (based on current locale)

#pragma mark - Date modify
///=============================================================================
/// @name Date modify
///=============================================================================

/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (nullable NSDate *)kk_dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (nullable NSDate *)kk_dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (nullable NSDate *)kk_dateByAddingWeeks:(NSInteger)weeks;

/**
 Returns a date representing the receiver date shifted later by the provided number of days.
 
 @param days  Number of days to add.
 @return Date modified by the number of desired days.
 */
- (nullable NSDate *)kk_dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (nullable NSDate *)kk_dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (nullable NSDate *)kk_dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (nullable NSDate *)kk_dateByAddingSeconds:(NSInteger)seconds;


@end
