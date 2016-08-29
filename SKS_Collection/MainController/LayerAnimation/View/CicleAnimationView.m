//
//  CicleProgressView.m
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CicleAnimationView.h"

@implementation CicleAnimationView
{
    CGFloat _progress;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bezierPath = ({
        CGRect frame = self.bounds;
        
        CGPoint center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        CGFloat radius = frame.size.width * 0.5 - [self lineWidth] * 0.5;
        CGFloat startA = 0;
        CGFloat endA = M_PI * 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES]; // clockwise:YES 即顺时针
        
        path;
    });
    
    self.sharpLayer.path = self.bezierPath.CGPath;
}

- (void)showWithProgress:(CGFloat)progress
{
    _progress = progress;
    
    // 如果另起一个dispatch，在 viewDidLoad 方法中创建并显示progress将没有效果
    dispatch_async(dispatch_get_main_queue(), ^{
        self.sharpLayer.strokeEnd = progress;
    });
}

@end



