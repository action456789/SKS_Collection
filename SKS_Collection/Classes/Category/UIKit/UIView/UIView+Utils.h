//
//  UIView+Tool.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

// 判断View是否显示在屏幕上
- (BOOL)kk_isDisplayedInScreen;

/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)kk_removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *kk_viewController;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat kk_visibleAlpha;

@end
