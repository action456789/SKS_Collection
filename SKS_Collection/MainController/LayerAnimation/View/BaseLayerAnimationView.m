//
//  LayerAnimationBaseView.m
//  SKS_Collection
//
//  Created by KeSen on 8/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BaseLayerAnimationView.h"

#define kDefaultColor [UIColor whiteColor]
#define kOrangeColor  [UIColor colorWithRed:1 green:102.f/255.f blue:0 alpha:1]
#define kDefaultWidth 3.f
#define kDefaultDuration 0.3f
#define kDefaultDelay 0.2f

@interface BaseLayerAnimationView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation BaseLayerAnimationView

- (instancetype)init
{
    if (self = [super init]) {
        [self createSharpLayer];
    }
    return self;
}

- (void)createPath
{
}

- (void)createSharpLayer
{
    if (!self.path) {
        return;
    }
    
    _shapeLayer = ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        
        layer.fillColor   = [UIColor clearColor].CGColor;
        layer.strokeColor = [self lineColor].CGColor;
        layer.lineWidth   = _lineWidth;
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), dispatch_get_main_queue(), ^{
        self.shapeLayer.strokeEnd = 1;
    });
}

- (void)hideWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.shapeLayer.strokeEnd = 0.f;
    });
}

#pragma mark - setter

- (void)setDuration:(CGFloat)duration {
    duration > kDefaultDuration ? (_duration = duration) : (_duration = kDefaultDuration);
}

- (void)setDelay:(CGFloat)delay {
    delay > kDefaultDelay ? (_delay = delay) : (_delay = kDefaultDelay);
}

- (void)setLineWidth:(CGFloat)lineWidth {
    lineWidth > kDefaultWidth ? (_lineWidth = lineWidth) : (_lineWidth = kDefaultWidth);
}

- (void)setLineColor:(UIColor *)lineColor {
    lineColor ? (_lineColor = lineColor) : (_lineColor = kDefaultColor);
}

@end
