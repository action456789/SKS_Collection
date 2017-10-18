//
//  CicleProgressView.m
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "LightControlPannelProgressView.h"
#import "UILabel+NumberIncreaseAnim.h"

@interface LightControlPannelProgressView()

@property (nonatomic, strong) NSProgress *progress;

@property (nonatomic, assign) BOOL isIncreasing;
@property (nonatomic, assign) BOOL isDecreasing;

@end

@implementation LightControlPannelProgressView
{
    UILabel *_progressLabel;
    
    UIBezierPath *_innerOvarPath;
    CAShapeLayer *_innerOvarLayer;
    
    UIBezierPath *_outOvarPath;
    CAShapeLayer *_outOvarLayer;
    CGFloat _outOvarPathlineWidth;
    
    CGPoint _center;
    CGFloat _radius;
    
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initData];
    }
    return self;
}

- (void)initData {
    _progress = [NSProgress progressWithTotalUnitCount:100];
    
    [_progress addObserver:self forKeyPath:@"fractionCompleted"
                   options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                   context:nil];
    
    _outOvarPathlineWidth = 10;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc {
    [_progress removeObserver:self forKeyPath:@"fractionCompleted"];
    [self _clearTimer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    NSLog(@"进度= %f",_progress.fractionCompleted);
//    NSLog(@"description: %@", _progress.description);
//    NSLog(@"localizedDescription: %@", _progress.localizedDescription);
//    NSLog(@"localizedAdditionalDescription: %@", _progress.localizedAdditionalDescription);
    //    _progressLabel.text = [NSString stringWithFormat:@"%lld%%", _progress.completedUnitCount];

    int64_t old = [change[@"old"] floatValue] * 100;
    int64_t new = [change[@"new"] floatValue] * 100;
    [_progressLabel kk_animateFromNumber:old toNumber:new duration:0.3 delay:0];
}

- (void)createInnerBezierPath {
    if (_innerOvarPath || _innerOvarLayer) {
        return;
    }
    
    CGFloat radius = _outOvarPathlineWidth * 0.5;
    CGFloat w = self.frame.size.width - radius * 2;
    CGFloat h = self.frame.size.height - radius * 2;
    _innerOvarPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(radius, radius, w, h)];
    
    _innerOvarLayer = [CAShapeLayer layer];
    _innerOvarLayer.path = _innerOvarPath.CGPath;
    _innerOvarLayer.strokeColor = [UIColor whiteColor].CGColor;
    _innerOvarLayer.fillColor = [UIColor clearColor].CGColor;
    _innerOvarLayer.lineWidth = 2;
    _innerOvarLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:_innerOvarLayer];
}

- (void)createOutterBezierPath {
    if (_outOvarPath || _outOvarLayer) {
        return;
    }
    
    BOOL clockwise = YES;
    CGFloat startA = M_PI_2 * 3;
    CGFloat endA = startA + (2.0 * M_PI * (clockwise ? 1.0 : -1.0));
    
    _outOvarPath = [UIBezierPath bezierPathWithArcCenter:_center radius:_radius startAngle:startA endAngle:endA clockwise:clockwise]; // clockwise:YES 即顺时针
    
    _outOvarLayer = [CAShapeLayer layer];
    _outOvarLayer.path = _outOvarPath.CGPath;
    _outOvarLayer.strokeColor = [UIColor whiteColor].CGColor;
    _outOvarLayer.fillColor = [UIColor clearColor].CGColor;
    _outOvarLayer.lineWidth = _outOvarPathlineWidth;
    _outOvarLayer.lineJoin = @"round";;
    _outOvarLayer.lineCap = @"round";
    _outOvarLayer.strokeStart = 0.f;
    _outOvarLayer.strokeEnd   = 0.f;
    _outOvarLayer.shadowOpacity = 1;
    _outOvarLayer.shadowColor = [UIColor whiteColor].CGColor;
    _outOvarLayer.shadowRadius = 5;
    _outOvarLayer.shadowOffset = CGSizeMake(0, 0);
    
    [self.layer addSublayer:_outOvarLayer];
}

- (void)createProgressLabel {
    if (_progressLabel) {
        return;
    }
    _progressLabel = ({
        UILabel *label = [UILabel new];
        label.bounds = CGRectMake(0, 0, self.frame.size.width * 0.8, self.frame.size.height * 0.7);
        label.center = _center;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"0%";
        label.font = [UIFont fontWithName:@"Heiti SC" size:ceil(self.frame.size.width/4.0f)];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        
        label;
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    _radius = self.frame.size.width * 0.5 - _outOvarPathlineWidth * 0.5;
    
    [self createInnerBezierPath];
    [self createOutterBezierPath];
    [self createProgressLabel];
}

- (void)showWithProgress:(int64_t)progress {
    _progress.completedUnitCount = progress;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _outOvarLayer.strokeEnd = progress * 0.01;
    });
}

// 增加 increasedUnit 个单位, increasedUnit 为负数时为减少
- (void)increaseWithUnit:(int64_t)unit {
    int64_t p = _progress.completedUnitCount;
    if (p >= 100 && unit > 0) { // 增加
        p = 100;
        return;
    } else if (p <= 0 && unit < 0) { // 减少
        p = 0;
        return;
    }
    
    [self showWithProgress:(p + unit)];
    
    if ([self.delegate respondsToSelector:@selector(lightControlPannelProgressView:didValueUpdated:)]) {
        [self.delegate lightControlPannelProgressView:self didValueUpdated:self.progress.completedUnitCount];
    }
}

// 增加
- (void)startIncrease {
    // 已经在增加
    if (self.isIncreasing) {
        return;
    }
    // 如果正在增加时，执行减少操作
    if (self.isDecreasing) {
        [self endDecrease];
    }
    
    self.isIncreasing = YES;
    [self _startTimer];
}

- (void)endIncrease {
    if (!self.isIncreasing) {
        return;
    }
    self.isIncreasing = NO;
    [self _clearTimer];
    
    if ([self.delegate respondsToSelector:@selector(lightControlPannelProgressView:didValueUpdated:)]) {
        [self.delegate lightControlPannelProgressView:self didValueUpdated:self.progress.completedUnitCount];
    }
}

// 减少
- (void)startDecrease {
    // 已经在减少
    if (self.isDecreasing) {
        return;
    }
    // 如果正在减少时，执行增加操作
    if (self.isIncreasing) {
        [self endIncrease];
    }
    
    self.isDecreasing = YES;
    [self _startTimer];
}

- (void)endDecrease {
    if (!self.isDecreasing) {
        return;
    }
    self.isDecreasing = NO;
    [self _clearTimer];
    
    if ([self.delegate respondsToSelector:@selector(lightControlPannelProgressView:didValueUpdated:)]) {
        [self.delegate lightControlPannelProgressView:self didValueUpdated:self.progress.completedUnitCount];
    }
}

- (void)_startTimer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(_timerEvent)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    [_timer fire];
}

- (void)_timerEvent {
    if (self.isIncreasing) {
        [self increaseWithUnit:1];
    } else {
        [self increaseWithUnit:-1];
    }
    
    int64_t p = _progress.completedUnitCount;
    if (p >= 100) {
        [self endIncrease];
    }
    
    if (p <= 0) {
        [self endDecrease];
    }
}

- (void)_clearTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
