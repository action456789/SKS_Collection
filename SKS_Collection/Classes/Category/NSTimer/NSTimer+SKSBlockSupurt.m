//
//  NSTimer+SKSBlockSupurt.m
//  KsCollection
//
//  Created by KeSen on 16/6/20.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "NSTimer+SKSBlockSupurt.h"

@implementation NSTimer (SKSBlockSupurt)

+ (NSTimer *)sks_scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)())block
{
    return [NSTimer scheduledTimerWithTimeInterval:ti
                                            target:self
                                          selector:@selector(p_blockInvoke:)
                                          userInfo:[block copy]
                                           repeats:yesOrNo];
}

+ (void)p_blockInvoke:(NSTimer *)timer
{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
        block = nil;
    }
}

@end
