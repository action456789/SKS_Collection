//
//  CrossAnimationView.m
//  SKS_Collection
//
//  Created by KeSen on 8/26/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CrossAnimationView.h"

@implementation CrossAnimationView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bezierPath = ({
        CGRect frame = self.bounds;
        
        CGFloat h = frame.size.height;
        CGFloat w = frame.size.width;
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
        
        path;
    });
    
    self.sharpLayer.path = self.bezierPath.CGPath;
}

@end
