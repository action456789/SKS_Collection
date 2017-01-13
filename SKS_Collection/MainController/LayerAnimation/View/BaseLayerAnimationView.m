//
//  LayerAnimationBaseView.m
//  SKS_Collection
//
//  Created by KeSen on 8/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BaseLayerAnimationView.h"

#define kDefaultColor [[UIColor blackColor] colorWithAlphaComponent:0.7];
#define kOrangeColor  [UIColor colorWithRed:1 green:102.f/255.f blue:0 alpha:1]
#define kDefaultWidth 1.f
#define kDefaultDuration 0.3f
#define kDefaultDelay 0.f

@implementation BaseLayerAnimationView

- (void)layoutSubviews
{
    self.sharpLayer = ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        
        layer.fillColor   = [UIColor clearColor].CGColor;
        layer.strokeColor = [self lineColor].CGColor;
        layer.lineWidth   = [self lineWidth];
        layer.strokeStart = 0.f;
        layer.strokeEnd   = 0.f;
        layer.lineCap = @"round";
        layer.lineJoin = @"round";
        
        [self.layer addSublayer:layer];
        
        layer;
    });
}

- (void)showWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay
{
    self.duration = duration;
    self.delay = delay;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.duration;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), dispatch_get_main_queue(), ^{
        [self.sharpLayer addAnimation:animation forKey:nil];
    });
}

- (void)hideWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.sharpLayer.strokeEnd = 0.f;
    });
}

#pragma mark - setter, getter
- (CGFloat)delay {
    return _delay > kDefaultDelay ? _delay : kDefaultDelay;
}
- (CGFloat)lineWidth {
    return _lineWidth > kDefaultWidth ? _lineWidth : kDefaultWidth;
}
- (UIColor *)lineColor {
    return _lineColor ? _lineColor : kDefaultColor;
}
- (CGFloat)duration {
    return _duration > kDefaultDuration ? _duration : kDefaultDuration;
}

@end
