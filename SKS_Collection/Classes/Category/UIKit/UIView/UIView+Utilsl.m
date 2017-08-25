//
//  UIView+Tool.m
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

// 判断View是否显示在屏幕上
- (BOOL)kk_isDisplayedInScreen {
    if (self == nil) return FALSE;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) return FALSE;
    
    // 若view 隐藏
    if (self.hidden) return FALSE;
    
    // 若没有superview
    if (self.superview == nil) return FALSE;
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) return  FALSE;
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) return FALSE;
    
    return TRUE;
}

- (void)kk_removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)kk_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)kk_visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

@end
