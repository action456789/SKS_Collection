//
//  UIDevice+CPU.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/28.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CPU)

#pragma mark - CPU Information
///=============================================================================
/// @name CPU Information
///=============================================================================

/// Avaliable CPU processor count.
@property (nonatomic, readonly) NSUInteger kk_cpuCount;

/// Current CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float kk_cpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nullable, nonatomic, readonly) NSArray<NSNumber *> *kk_cpuUsagePerProcessor;

@end
