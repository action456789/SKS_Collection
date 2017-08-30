//
//  CALayer+Transform.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/30.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "CALayer+Transform.h"

@implementation CALayer (Transform)

- (CGFloat)kk_transformRotation {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation"];
    return v.doubleValue;
}

- (void)setKk_transformRotation:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation"];
}

- (CGFloat)kk_transformRotationX {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.x"];
    return v.doubleValue;
}

- (void)setKk_transformRotationX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.x"];
}

- (CGFloat)kk_transformRotationY {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.y"];
    return v.doubleValue;
}

- (void)setKk_transformRotationY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.y"];
}

- (CGFloat)kk_transformRotationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.rotation.z"];
    return v.doubleValue;
}

- (void)setKk_transformRotationZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.rotation.z"];
}

- (CGFloat)kk_transformScaleX {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.x"];
    return v.doubleValue;
}

- (void)setKk_transformScaleX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.x"];
}

- (CGFloat)kk_transformScaleY {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.y"];
    return v.doubleValue;
}

- (void)setKk_transformScaleY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.y"];
}

- (CGFloat)kk_transformScaleZ {
    NSNumber *v = [self valueForKeyPath:@"transform.scale.z"];
    return v.doubleValue;
}

- (void)setKk_transformScaleZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale.z"];
}

- (CGFloat)kk_transformScale {
    NSNumber *v = [self valueForKeyPath:@"transform.scale"];
    return v.doubleValue;
}

- (void)setKk_transformScale:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.scale"];
}

- (CGFloat)kk_transformTranslationX {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.x"];
    return v.doubleValue;
}

- (void)setKk_transformTranslationX:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.x"];
}

- (CGFloat)kk_transformTranslationY {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.y"];
    return v.doubleValue;
}

- (void)setKk_transformTranslationY:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.y"];
}

- (CGFloat)kk_transformTranslationZ {
    NSNumber *v = [self valueForKeyPath:@"transform.translation.z"];
    return v.doubleValue;
}

- (void)setKk_transformTranslationZ:(CGFloat)v {
    [self setValue:@(v) forKeyPath:@"transform.translation.z"];
}

- (CGFloat)kk_transformDepth {
    return self.transform.m34;
}

- (void)setKk_transformDepth:(CGFloat)v {
    CATransform3D d = self.transform;
    d.m34 = v;
    self.transform = d;
}

@end
