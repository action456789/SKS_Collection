//
//  UIView+CornerRadio.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UIView+CornerRadio.h"

@implementation UIView (CornerRadio)

// 创建圆角
- (void)kk_createCornerRadius:(CGFloat)radio {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radio;
}

// 创建圆角，可以自定义是个角
// Swift 用法
// eg: view.createRadio(byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadio: 10)

- (void)kk_createCornerRadius:(CGFloat)radio byRoundingCorners: (UIRectCorner)corners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radio, radio)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

// 创建边框
- (void)kk_createBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (borderWidth > 0 && borderColor != nil) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.CGColor;
    }
}

// 创建阴影
- (void)kk_createShadowRadius:(CGFloat)radius opacity:(CGFloat)opacity {
    self.layer.shadowRadius = radius;//阴影半径，默认3
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(-1, 0); //shadowOffset阴影偏移, 默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = opacity;//阴影透明度，默认0
}

- (void)kk_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
