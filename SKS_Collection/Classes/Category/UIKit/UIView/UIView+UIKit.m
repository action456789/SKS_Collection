//
//  UIView+Convenient.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UIView+UIKit.h"
#import "UIImage+Creator.h"

@implementation UIView (UIKit)

// 给 UIView 最顶层添加一个 UIButton，进行事件响应，并且显示高亮颜色
- (UIButton *)addButtonOnTopWithHighLightColor: (UIColor *)color {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.bounds;
    
    UIImage *normalImage = [UIImage kk_imageWithColor:[UIColor clearColor] size:btn.frame.size];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    UIColor *highLightColor = color ? color : [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    UIImage *highlightImage = [UIImage kk_imageWithColor: highLightColor size:btn.frame.size];
    [btn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    [self addSubview:btn];
    
    return btn;
}

+ (UIImageView *)kk_findLineView:(UIView*)view {
    BOOL isLine = view.bounds.size.height <= 1.0 || view.bounds.size.width <= 1.0;
    if ([view isKindOfClass:[UIImageView class]] && isLine) {
        return (UIImageView*) view;
    }for (UIImageView *subview in view.subviews) {
        UIImageView *lineview = [self kk_findLineView:subview];
        if (lineview) {
            return lineview;
        }
    }
    return nil;
}

@end
