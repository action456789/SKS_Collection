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

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) UIBezierPath *checkMarkPath;

@property (nonatomic, strong) UIColor *strockColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) NSTimeInterval delay;

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, strong) UIBezierPath *crossPath;

// default is checkmark animation
@property (nonatomic, assign) KSLayAnimationType animationType;

@property (nonatomic, assign) CGSize contentSize;

@end

@implementation KSLayAnimationView

#pragma mark - life cycle

+ (instancetype)layAnimationView {
    KSLayAnimationView *animationView = [[KSLayAnimationView alloc] initLayAnimationViewWithFrame:CGRectZero strockColor:kDefaultColor duration:kDefaultDuration lineWidth:kDefaultWidth];
    animationView.bounds = CGRectMake(0, 0, animationView.contentSize.width, animationView.contentSize.height);
    return animationView;
}

- (instancetype)initLayAnimationViewWithFrame:(CGRect)frame strockColor:(UIColor *)color duration:(NSTimeInterval)duration lineWidth:(CGFloat)lineWidth {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.shapeLayer.strokeColor = color.CGColor;
        self.lineWidth = lineWidth;
        self.shapeLayer.lineWidth = self.lineWidth;
        self.animationType = KSLayAnimationTypeCheckMark;
    }
    
    return self;
}

#pragma mark - private method

- (void)showWithDuration:(NSTimeInterval)duration type:(KSLayAnimationType)type {
    
    switch (type) {
        case KSLayAnimationTypeCheckMark: {
            self.shapeLayer.path = self.checkMarkPath.CGPath;
            break;
        }
            
        case KSLayAnimationTypeCross: {
            self.shapeLayer.path = self.crossPath.CGPath;
            break;
        }
    }
    
    // 添加 layer 和动画
    [self.layer addSublayer:self.shapeLayer];
    
    self.duration = duration;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.duration;
    animation.delegate = self;
    animation.fromValue = [NSNumber numberWithInteger:0];
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.shapeLayer addAnimation:animation forKey:@"key"];

}

- (void)hide {
    self.shapeLayer.strokeEnd = 0.f;
}

#pragma mark - public method

- (void)showWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay type:(KSLayAnimationType)type {
    
    self.duration = duration;
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self showWithDuration:self.duration type:type];
    });
}

- (void)hideWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self hide];
    });
}

#pragma mark - getter

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = kOrangeColor.CGColor;
        _shapeLayer.lineWidth   = self.lineWidth;
        _shapeLayer.strokeStart = 0.f;
        _shapeLayer.strokeEnd   = 0.f;
        _shapeLayer.lineCap = @"round";
        _shapeLayer.lineJoin = @"round";
        
        
        _shapeLayer.path = self.checkMarkPath.CGPath;
    }
    return _shapeLayer;
}

- (UIBezierPath *)checkMarkPath {
    if (!_checkMarkPath) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        CGFloat fromX = 0 + self.lineWidth;
        CGFloat fromY = 270.f / 400.f * (self.bounds.size.height);
        [line moveToPoint:CGPointMake(fromX, fromY)];
        
        CGFloat toX1  = 167.f / 400.f * (self.bounds.size.width);
        CGFloat toY1  = self.bounds.size.height - self.lineWidth;
        [line addLineToPoint:CGPointMake(toX1, toY1)];
        
        CGFloat toX2  = self.bounds.size.width - self.lineWidth;
        CGFloat toY2  = 0 + self.lineWidth;
        [line addLineToPoint:CGPointMake(toX2, toY2)];
        
        _checkMarkPath = line;
    }
    return _checkMarkPath;
}

- (UIBezierPath *)crossPath {
    if (!_crossPath) {
        CGFloat h = self.bounds.size.height;
        CGFloat w = self.bounds.size.width;
        CGFloat deltaX = w / 5;
        CGFloat deltaY = h / 5;
        
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

@synthesize lineWidth = _lineWidth;
- (CGFloat)lineWidth {
    _lineWidth = _lineWidth > kDefaultWidth ? _lineWidth : kDefaultWidth;
    return _lineWidth;
}

- (NSTimeInterval)delay {
    _delay = _delay > kDefaultDelay ? _delay : kDefaultDelay;
    return _delay;
}

- (NSTimeInterval)duration {
    _duration = _duration > kDefaultDuration ? _duration : kDefaultDuration;
    return _duration;
}

#pragma mark - setter
- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = lineWidth;
}

- (CGSize)contentSize {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    switch (self.animationType) {
        case KSLayAnimationTypeCheckMark:
            return indicator.frame.size;
            break;
            
        case KSLayAnimationTypeCross:
            return CGSizeMake(indicator.frame.size.width * 0.6, indicator.frame.size.height * 0.6);
            break;
            
        default:
            break;
    }
}

@end
