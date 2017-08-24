//
//  NSTimer+SKSBlockSupurt.m
//  KsCollection
//
//  Created by KeSen on 16/6/20.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "NSTimer+BlockSupurt.h"

@implementation NSTimer (BlockSupurt)

// NSRunloopDefaultMode
+ (NSTimer *)sks_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)(void))block
{
    return [NSTimer scheduledTimerWithTimeInterval:ti
                                            target:self
                                          selector:@selector(_blockInvoke:)
                                          userInfo:[block copy]
                                           repeats:yesOrNo];
}

+ (NSTimer *)sks_scheduledTimerInCommonModesWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)(void))block
{
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast]
                                              interval:ti
                                                target:self
                                              selector:@selector(_blockInvoke:)
                                              userInfo:[block copy]
                                               repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return timer;
}

+ (void)_blockInvoke:(NSTimer *)timer
{
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
        block = nil;
    }
}

@end
