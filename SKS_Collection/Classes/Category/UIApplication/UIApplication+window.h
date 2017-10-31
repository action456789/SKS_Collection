//
//  UIApplication+window.h
//  SmartSocket
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 宋旭华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (window)

+ (UIWindow *)kk_keyWindow;
+ (UIWindow *)kk_window;

+ (UIViewController *)kk_rootViewController;
+ (void)kk_setRootViewController:(UIViewController *)viewController;

@end
