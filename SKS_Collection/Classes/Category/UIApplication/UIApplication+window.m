//
//  UIApplication+window.m
//  SmartSocket
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 宋旭华. All rights reserved.
//

#import "UIApplication+window.h"

@implementation UIApplication (window)

+ (UIWindow *)kk_keyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIWindow *)kk_window {
    return [UIApplication sharedApplication].delegate.window;
}

+ (UIViewController *)kk_rootViewController {
    return [[[self class] kk_keyWindow] rootViewController];
}

+ (void)kk_setRootViewController:(UIViewController *)viewController {
    [self kk_keyWindow].rootViewController = viewController;
}

@end
