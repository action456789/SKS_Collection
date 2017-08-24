//
//  NSTimer+SKSBlockSupurt.h
//  KsCollection
//
//  Created by KeSen on 16/6/20.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockSupurt)

+ (NSTimer *)sks_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)(void))block;

+ (NSTimer *)sks_scheduledTimerInCommonModesWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)(void))block;

@end
