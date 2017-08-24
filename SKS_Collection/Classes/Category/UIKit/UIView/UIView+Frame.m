//
//  UIView+KS.m
//  iFanPhoto
//
//  Created by kesen on 14/11/27.
//  Copyright (c) 2014年 柯森. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setKk_x:(CGFloat)kk_x
{
    CGRect frame = self.frame;
    frame.origin.x = kk_x;
    self.frame = frame;
}

- (CGFloat)kk_x
{
    return self.frame.origin.x;
}

- (void)setKk_y:(CGFloat)kk_y
{
    CGRect frame = self.frame;
    frame.origin.y = kk_y;
    self.frame = frame;
}

- (CGFloat)kk_y
{
    return self.frame.origin.y;
}

- (void)setKk_width:(CGFloat)kk_width
{
    CGRect frame = self.frame;
    frame.size.width = kk_width;
    self.frame = frame;
}

- (CGFloat)kk_width
{
    return self.frame.size.width;
}

- (void)setKk_height:(CGFloat)kk_height
{
    CGRect frame = self.frame;
    frame.size.height = kk_height;
    self.frame = frame;
}

- (CGFloat)kk_height
{
    return self.frame.size.height;
}

- (void)setKk_size:(CGSize)kk_size
{
    CGRect frame = self.frame;
    frame.size = kk_size;
    self.frame = frame;
}

- (CGSize)kk_size
{
    return self.frame.size;
}

- (void)setKk_origin:(CGPoint)kk_origin
{
    CGRect frame = self.frame;
    frame.origin = kk_origin;
    self.frame = frame;
}

- (CGPoint)kk_origin
{
    return self.frame.origin;
}

- (CGFloat)kk_centerX
{
    return self.center.x;
}

- (void)setKk_centerX:(CGFloat)kk_centerX
{
    CGPoint center = self.center;
    center.x = kk_centerX;
    self.center = center;
}

- (CGFloat)kk_centerY
{
    return self.center.y;
}

- (void)setKk_centerY:(CGFloat)kk_centerY
{
    CGPoint center = self.center;
    center.y = kk_centerY;
    self.center = center;
}

@end
