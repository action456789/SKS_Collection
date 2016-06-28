//
//  NSTimer+SKSBlockSupurt.h
//  KsCollection
//
//  Created by KeSen on 16/6/20.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SKSBlockSupurt)

+ (NSTimer *)sks_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)())block;

@end
