//
//  CAGradientLayer+Creator.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/9/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "CAGradientLayer+Creator.h"

@implementation CAGradientLayer (Creator)

// 创建一个水平渐变图层
+ (CAGradientLayer *)kk_layerWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = frame;
    layer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(0, 0.5);
    layer.locations = @[@(0.1), @(1.0)];
    return layer;
}

@end
