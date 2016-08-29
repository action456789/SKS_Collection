//
//  CheckMarkAnimationView.m
//  SKS_Collection
//
//  Created by KeSen on 8/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CheckMarkAnimationView.h"

@implementation CheckMarkAnimationView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bezierPath = ({
        CGRect frame = self.bounds;
        
        CGFloat h = frame.size.height;
        CGFloat w = frame.size.width;
        
        UIBezierPath *line = [UIBezierPath bezierPath];
        CGFloat fromX = 0 + self.lineWidth;
        CGFloat fromY = 270.f / 400.f * h;
        [line moveToPoint:CGPointMake(fromX, fromY)];
        
        CGFloat toX1  = 167.f / 400.f * w;
        CGFloat toY1  = h - self.lineWidth;
        [line addLineToPoint:CGPointMake(toX1, toY1)];
        
        CGFloat toX2  = w - self.lineWidth;
        CGFloat toY2  = 0 + self.lineWidth;
        [line addLineToPoint:CGPointMake(toX2, toY2)];
        
        line;
    });
    
    self.sharpLayer.path = self.bezierPath.CGPath;
}

@end
