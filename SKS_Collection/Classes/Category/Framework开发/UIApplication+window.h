//
//  UIApplication+window.h
//  SmartSocket
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 sen.ke All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (window)


/**
 获取 AppDelegate 的 keyWindow 对象
 */
+ (UIWindow *)kk_keyWindow;


/**
 获取 获取 AppDelegate 的 window 对象
 */
+ (UIWindow *)kk_window;


/**
 获取 AppDelegate keyWindow 的 rootViewController
 */
+ (UIViewController *)kk_rootViewController;


/**
 设置 AppDelegate keyWindow 的 rootViewController
 */
+ (void)kk_setRootViewController:(UIViewController *)viewController;

@end
