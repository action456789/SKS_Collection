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
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation CicleProgressView

- (instancetype)init
{
    if (self = [super init]) {
        [self drawCicle];
    }
    return self;
}

- (void)drawCicle
{
    CGFloat lineWidth = (self.lineWidth <= 0 ? 1 : self.lineWidth);
    UIColor *lineColor = (self.lineColor == nil ? [UIColor blackColor] : self.lineColor);
    CGSize size = self.bounds.size;
    CGFloat radius = size.width / 2.f - lineWidth / 2.f;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.center
                                                         radius:radius
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    
    _circleLayer = ({
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = lineColor.CGColor;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        shapeLayer.lineWidth = lineWidth;
        shapeLayer.strokeStart = 0.f;
        shapeLayer.strokeEnd = 0.f;
        shapeLayer.lineCap = @"round";
        shapeLayer.lineJoin = @"round";
        
        shapeLayer.path = circlePath.CGPath;
        
        [self.layer addSublayer:_circleLayer];
        
        shapeLayer;
    });

    
    
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.delegate = self;
    animation.fromValue = @(0);
    animation.toValue = @(1.0f);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [_circleLayer addAnimation:animation forKey:@"key"];
}

@end



