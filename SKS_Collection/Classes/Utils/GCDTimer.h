//
//  GCDTimer.h
//  SKS_Collection
//
//  Created by KeSen on 9/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CGDTimerAccuracy) {
    CGDTimerAccuracyBest, // default
    CGDTimerAccuracyGood,
    CGDTimerAccuracyNormal,
};

@interface GCDTimer : NSObject

@property (nonatomic, assign) CGDTimerAccuracy accuracy;

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                         queue:(dispatch_queue_t)queue
                                       repeats:(BOOL)isRepeats
                                         delay:(NSTimeInterval)delay
                                         block:(void (^)())block;

- (void)invalidate;

@end
