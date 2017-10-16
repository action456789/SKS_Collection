//
//  CicleProgressView.m
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CicleProgressAnimationView.h"

@implementation CicleProgressAnimationView
{
    NSProgress *_progress;
    UILabel *_progressLabel;
    
    CGPoint _center;
    CGFloat _radius;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _progress = [NSProgress progressWithTotalUnitCount:1.0];
    }
    return self;
}

- (void)createBezierPath {
    if (self.bezierPath) {
        return;
    }
    self.bezierPath = ({
        CGFloat startA = 0;
        CGFloat endA = M_PI * 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_center radius:_radius startAngle:startA endAngle:endA clockwise:YES]; // clockwise:YES 即顺时针
        
        path;
    });
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
        [self addSubview:label];
        
        label;
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    _radius = self.frame.size.width * 0.5 - [self lineWidth] * 0.5;
    
    [self createBezierPath];
    self.sharpLayer.path = self.bezierPath.CGPath;
    [self createProgressLabel];
}

- (void)showWithProgress:(int64_t)progress
{
    _progress.completedUnitCount = progress;
    
    if (self.animationType == KSKLayerAnimationTypeDefault) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sharpLayer.strokeEnd = progress;
            _progressLabel.text = [NSString stringWithFormat:@"%.0lld%%", progress * 100];
        });
    }
}

@end
