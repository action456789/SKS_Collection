//
//  KKDay.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/11.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum KK_WEEK_DAY: NSUInteger {
    kk_week_monday = 1,
    kk_week_tuesday,
    kk_week_wednesday,
    kk_week_thursday,
    kk_week_friday,
    kk_week_saturday,
    kk_week_sunday,
}KK_WEEK_DAY;

@interface KKDay : NSObject

@property (nonatomic, assign) KK_WEEK_DAY week_day;

+ (instancetype)day:(KK_WEEK_DAY)weekDay;
- (instancetype)initWithIndex:(NSInteger)index;

@end
