//
//  CALayer+KSKit.m
//  KsCollection
//
//  Created by KeSen on 15/12/11.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "CALayer+KS_Animate.h"

@implementation CALayer (KS_Animate)

- (void)pauseLayer
{
    CALayer *layer = self;
    
    if (layer.speed == 0.0f) {
        return;
    }
    
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    // 让CALayer的时间停止走动
    layer.speed = 0.0;
    // 让CALayer的时间停留在pausedTime这个时刻
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer
{
    CALayer *layer = self;
    
    if (layer.speed == 1.0f) {
        return;
    }
    
    CFTimeInterval pausedTime = layer.timeOffset;
    // 1. 让CALayer的时间继续行走
    layer.speed = 1.0;
    // 2. 取消上次记录的停留时刻
    layer.timeOffset = 0.0;
    // 3. 取消上次设置的时间
    layer.beginTime = 0.0;
    // 4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    // 5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
    layer.beginTime = timeSincePause;
}
@end
