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


- (UIColor *)lineColor {
    return _lineColor == nil ? [UIColor orangeColor] : _lineColor;
}

- (CGFloat)lineWidth {
    return _lineWidth <= 0 ? 1 : _lineWidth;
}

- (CGFloat)duration
{
    return _duration <=0 ? 0.2 : _duration;
}

- (void)layoutSubviews
{
    if (_circleProgressPath || _shapeLayer) {
        return;
    }
    
    _circleProgressPath = ({
        CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        CGFloat radius = self.bounds.size.width * 0.5 - [self lineWidth] * 0.5;
        CGFloat startA = 0;
        CGFloat endA = M_PI * 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES]; // clockwise:YES 即顺时针
        
        path;
    });
    
    _shapeLayer = ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        
        layer.fillColor   = [UIColor clearColor].CGColor;
        layer.strokeColor = [self lineColor].CGColor;
        layer.lineWidth   = [self lineWidth];
        layer.strokeStart = 0.f;
        layer.strokeEnd   = 0.f;
        layer.lineCap = @"round";
        layer.lineJoin = @"round";
        layer.path = _circleProgressPath.CGPath;
        
        [self.layer addSublayer:layer];
        
        layer;
    });
}

- (void)showWithProgress:(CGFloat)progress
{
    _progress = progress;
    
    // 如果另起一个dispatch，在 viewDidLoad 方法中创建并显示progress将没有效果
    dispatch_async(dispatch_get_main_queue(), ^{
        // 隐式动画
        _shapeLayer.strokeEnd = progress;
    });
}

@end



