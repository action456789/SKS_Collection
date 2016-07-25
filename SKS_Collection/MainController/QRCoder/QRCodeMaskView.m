//
//  QRCodeMaskView.m
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "QRCodeMaskView.h"

@implementation QRCodeMaskView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.cutOutRect];
    
    CGContextAddPath(context, path.CGPath);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextFillPath(context);
}

@end
