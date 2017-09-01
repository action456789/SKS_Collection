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
    CABasicAnimation *_animation;
    UILabel *_progressLabel;
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
    
    CGRect frame = self.bounds;
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    CGFloat radius = frame.size.width * 0.5 - [self lineWidth] * 0.5;
    
    self.bezierPath = ({
        CGFloat startA = 0;
        CGFloat endA = M_PI * 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES]; // clockwise:YES 即顺时针
        
        path;
    });
}

- (void)createProgressLabel {
    if (_progressLabel) {
        return;
    }
    
    CGRect frame = self.bounds;
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    
    _progressLabel = ({
        UILabel *label = [UILabel new];
        label.bounds = CGRectMake(0, 0, frame.size.width * 0.8, frame.size.height * 0.7);
        label.center = center;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"0%";
        label.font = [UIFont fontWithName:@"Heiti SC" size:ceil(frame.size.width/4.0f)];
        [self addSubview:label];
        
        label;
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self createBezierPath];

    self.sharpLayer.path = self.bezierPath.CGPath;
    
    [self createProgressLabel];
}

- (void)showWithProgress:(CGFloat)progress
{
    _progress.completedUnitCount = progress;
    
    if (self.animationType == KSKLayerAnimationTypeDefault) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sharpLayer.strokeEnd = progress;
            _progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        });
    }
}

@end
