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
    CGFloat _progress;
    CABasicAnimation *_animation;
    UILabel *_progressLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGRect frame = self.bounds;
    
    CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    CGFloat radius = frame.size.width * 0.5 - [self lineWidth] * 0.5;
    
    self.bezierPath = ({
        CGFloat startA = 0;
        CGFloat endA = M_PI * 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES]; // clockwise:YES 即顺时针
        
        path;
    });
    
    self.sharpLayer.path = self.bezierPath.CGPath;
    
    _progressLabel = ({
        UILabel *label = [UILabel new];
        label.bounds = CGRectMake(0, 0, frame.size.width * 0.8, frame.size.height * 0.7);
        label.center = center;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%.0f%%", _progress * 100];
        label.font = [UIFont fontWithName:@"Heiti SC" size:ceil(frame.size.width/4.0f)];
        [self addSubview:label];
        
        label;
    });
}

- (void)showWithProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (self.animationType == KSKLayerAnimationTypeDefault) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sharpLayer.strokeEnd = progress;
            _progressLabel.text = [NSString stringWithFormat:@"%.0f%%", _progress * 100];
        });
    }
}

@end
