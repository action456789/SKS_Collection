//
//  KSLayAnimationView.m
//  CheckMardAnimation
//
//  Created by KeSen on 16/1/27.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KSLayAnimationView.h"

#define kDefaultColor [UIColor whiteColor]
#define kOrangeColor  [UIColor colorWithRed:1 green:102.f/255.f blue:0 alpha:1]
#define kDefaultWidth 3.f
#define kDefaultDuration 0.3f
#define kDefaultDelay 0.2f

@interface KSLayAnimationView()

@property (nonatomic, strong) UIBezierPath *checkMarkPath;
@property (nonatomic, strong) UIBezierPath *crossPath;

@end

@implementation KSLayAnimationView
{
    CAShapeLayer *_shapeLayer;
    UIColor *_strockColor;
    CGFloat _lineWidth;
    NSTimeInterval _delay;
    NSTimeInterval _duration;
    KSLayAnimationType _animationType;
}

#pragma mark - life cycle

+ (instancetype)layAnimationView
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    return [[self class] layAnimationViewWithFrame:indicator.bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [[self class] layAnimationViewWithFrame:frame];
}

+ (instancetype)layAnimationViewWithFrame:(CGRect)frame
{
    return [[KSLayAnimationView alloc] initLayAnimationViewWithFrame:frame
                                                         strockColor:nil
                                                            duration:0
                                                           lineWidth:0];
}

- (instancetype)initLayAnimationViewWithFrame:(CGRect)frame
                                  strockColor:(UIColor *)color
                                     duration:(NSTimeInterval)duration
                                    lineWidth:(CGFloat)lineWidth
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        _lineWidth = lineWidth > kDefaultWidth ? lineWidth : kDefaultWidth;
        _duration = duration > kDefaultDuration ? duration : kDefaultDuration;
        _strockColor = color ? color : kDefaultColor;
        _animationType = KSLayAnimationTypeCheckMark;
        
        [self createSharpLayer];
    }
    
    return self;
}

- (void)createSharpLayer
{
    _shapeLayer = ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        
        layer.fillColor   = [UIColor clearColor].CGColor;
        layer.strokeColor = _strockColor.CGColor;
        layer.lineWidth   = _lineWidth;
        layer.strokeStart = 0.f;
        layer.strokeEnd   = 0.f;
        layer.lineCap = @"round";
        layer.lineJoin = @"round";
        layer.path = self.checkMarkPath.CGPath;
        [self.layer addSublayer:layer];
        
        layer;
    });
}

#pragma mark - public method

- (void)showWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay type:(KSLayAnimationType)type
{
    
    _duration = duration > kDefaultDuration ? duration : kDefaultDuration;
    _delay = delay > kDefaultDelay ? delay : kDefaultDelay;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay), dispatch_get_main_queue(), ^{
        switch (type) {
            case KSLayAnimationTypeCheckMark: {
                _shapeLayer.path = self.checkMarkPath.CGPath;
                break;
            }
                
            case KSLayAnimationTypeCross: {
                _shapeLayer.path = self.crossPath.CGPath;
                break;
            }
        }
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = _duration;
        animation.delegate = self;
        animation.fromValue = @(0);
        animation.toValue = @(1);
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        
        [_shapeLayer addAnimation:animation forKey:@"key"];
    });
}

- (void)hideWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        _shapeLayer.strokeEnd = 0.f;
    });
}

#pragma mark - getter

- (UIBezierPath *)checkMarkPath
{
    if (!_checkMarkPath) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        CGFloat fromX = 0 + _lineWidth;
        CGFloat fromY = 270.f / 400.f * (self.bounds.size.height);
        [line moveToPoint:CGPointMake(fromX, fromY)];
        
        CGFloat toX1  = 167.f / 400.f * (self.bounds.size.width);
        CGFloat toY1  = self.bounds.size.height - _lineWidth;
        [line addLineToPoint:CGPointMake(toX1, toY1)];
        
        CGFloat toX2  = self.bounds.size.width - _lineWidth;
        CGFloat toY2  = 0 + _lineWidth;
        [line addLineToPoint:CGPointMake(toX2, toY2)];
        
        _checkMarkPath = line;
    }
    return _checkMarkPath;
}

- (UIBezierPath *)crossPath
{
    if (!_crossPath) {
        CGFloat h = self.bounds.size.height;
        CGFloat w = self.bounds.size.width;
        CGFloat deltaX = w / 8;
        CGFloat deltaY = h / 8;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat fromX1 = 0.0 + deltaX;
        CGFloat fromY1 = 0.0 + deltaY;
        [path moveToPoint:CGPointMake(fromX1, fromY1)];
        
        CGFloat toX1 = h - deltaX;
        CGFloat toY1 = w - deltaY;
        [path addLineToPoint:CGPointMake(toX1, toY1)];
        
        CGFloat fromX2 = w - deltaX;
        CGFloat fromY2 = 0.0 + deltaY;
        [path moveToPoint:CGPointMake(fromX2, fromY2)];
        
        CGFloat toX2 = 0.0 + deltaX;
        CGFloat toY2 = h - deltaY;
        [path addLineToPoint:CGPointMake(toX2, toY2)];
        
        _crossPath = path;
        
    }
    return _crossPath;
}

#pragma mark - setter
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    _shapeLayer.lineWidth = lineWidth;
}

@end
