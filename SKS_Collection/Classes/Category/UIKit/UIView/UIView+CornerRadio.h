//
//  UIView+CornerRadio.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadio)

// 创建圆角
- (void)kk_createCornerRadius:(CGFloat)radio;

// 创建阴影
// tips: clipsToBounds为true不会显示阴影
- (void)kk_createShadowRadius:(CGFloat)radius opacity:(CGFloat)opacity;

// 创建圆角，可以自定义是个角
// Swift 用法
// eg: view.createRadio(byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadio: 10)
- (void)kk_createCornerRadius:(CGFloat)radio byRoundingCorners: (UIRectCorner)corners;

// 创建边框
- (void)kk_createBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)kk_setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

@end
