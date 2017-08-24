//
//  UIView+Tool.m
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

//在view下显示阴影
-(void)showShadow:(BOOL)val {
    self.layer.shadowOpacity = val ? 0.8f : 0.0f;
    if (val) {
        //        self.layer.cornerRadius = 4.0f;
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowRadius = 4.0f;
        //        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    }
}

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen {
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

// 获取 view 所在控制器
- (id)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return nextResponder;
        }
    }
    return nil;
}

@end
