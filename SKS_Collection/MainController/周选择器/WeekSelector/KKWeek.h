//
//  KKWeek.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KKDay;

@interface KKWeek : NSObject


+ (NSString *)daysDescription:(NSArray<KKDay *>*)days;

// 工作日
@property (nonatomic, strong) NSArray<KKDay *>* workingDay;

// 周末
@property (nonatomic, strong) NSArray<KKDay *>* weekend;

// 一周
@property (nonatomic, strong) NSArray<KKDay *>* aWeek;

@end
