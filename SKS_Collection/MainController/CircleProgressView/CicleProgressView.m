//
//  CicleProgressView.m
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CicleProgressView.h"

@interface CicleProgressView()

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, strong) CABasicAnimation *basicAnimation;

@end

@implementation CicleProgressView
{
    CAShapeLayer *_shapeLayer;
    UIColor *_strockColor;
    UIBezierPath *_circleProgressPath;
    CGFloat _progress;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    }
    
    return self;
}

- (void)layoutSubviews
{
    if (_circleProgressPath || _shapeLayer) {
        return;
    }
    
    _shapeLayer = ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        
        layer.fillColor   = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor redColor].CGColor;//[self lineColor].CGColor;
        layer.lineWidth   = 2.0;//[self lineWidth];
        layer.strokeStart = 0.f;
        layer.strokeEnd   = 0.f;
        layer.lineCap = @"round";
        layer.lineJoin = @"round";
        
        [self.layer addSublayer:layer];
        
        layer;
    });
    
    _circleProgressPath = ({
        CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        CGFloat radius = self.bounds.size.width * 0.5 - [self lineWidth] * 0.5;
        CGFloat startA = 0;
        CGFloat endA = 0 + M_PI * 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:radius
                                                        startAngle:startA
                                                          endAngle:endA
                                                         clockwise:YES];
        
        path;
    });
    
    _shapeLayer.path = _circleProgressPath.CGPath;
}

- (UIColor *)lineColor {
    return _lineColor == nil ? [UIColor blackColor] : _lineColor;
}

- (CGFloat)lineWidth {
    return _lineWidth <= 0 ? 1 : _lineWidth;
}

- (CGFloat)duration
{
    return _duration <=0 ? 0.2 : _duration;
}

- (CABasicAnimation *)basicAnimation
{
    if (!_basicAnimation) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = [self duration];
        animation.delegate = self;
        animation.fromValue = @(0);
        animation.toValue = @(1);
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        
        _basicAnimation = animation;
    }
    return _basicAnimation;
}

- (void)showWithProgress:(CGFloat)progress
{
    _progress = progress;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.delegate = self;
    animation.fromValue = @(0);
    animation.toValue = @(progress);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [_shapeLayer addAnimation:animation forKey:@"key"];
}

@end



