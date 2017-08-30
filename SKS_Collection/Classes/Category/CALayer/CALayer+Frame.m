//
//  CALayer+Frame.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/30.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "CALayer+Frame.h"

@implementation CALayer (Frame)

- (CGFloat)kk_left {
    return self.frame.origin.x;
}

- (void)setKk_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)kk_top {
    return self.frame.origin.y;
}

- (void)setKk_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)kk_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setKk_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)kk_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setKk_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)kk_width {
    return self.frame.size.width;
}

- (void)setKk_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)kk_height {
    return self.frame.size.height;
}

- (void)setKk_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)kk_center {
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5,
                       self.frame.origin.y + self.frame.size.height * 0.5);
}

- (void)setKk_center:(CGPoint)center {
    CGRect frame = self.frame;
    frame.origin.x = center.x - frame.size.width * 0.5;
    frame.origin.y = center.y - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGFloat)kk_centerX {
    return self.frame.origin.x + self.frame.size.width * 0.5;
}

- (void)setKk_centerX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x = centerX - frame.size.width * 0.5;
    self.frame = frame;
}

- (CGFloat)kk_centerY {
    return self.frame.origin.y + self.frame.size.height * 0.5;
}

- (void)setKk_centerY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y = centerY - frame.size.height * 0.5;
    self.frame = frame;
}

- (CGPoint)kk_origin {
    return self.frame.origin;
}

- (void)setKk_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)kk_frameSize {
    return self.frame.size;
}

- (void)setKk_frameSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
