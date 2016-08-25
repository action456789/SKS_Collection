//
//  CheckMarkAnimationView.m
//  SKS_Collection
//
//  Created by KeSen on 8/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CheckMarkAnimationView.h"

@implementation CheckMarkAnimationView

- (void)createPath
{
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
    
    self.path = line;
}

@end
