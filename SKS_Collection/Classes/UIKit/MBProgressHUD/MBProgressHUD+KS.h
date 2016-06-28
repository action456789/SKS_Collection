//
//  MBProgressHUD_KS.h
//  HudDemo
//
//  Created by KeSen on 15/9/14.
//  Copyright (c) 2015年 Matej Bukovinski. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (KS)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

/**
 *  显示一个背景是否可以与用户交互的 hud
 */

@property (nonatomic, assign) BOOL failureFlag;

+ (MBProgressHUD *)showMessage:(NSString *)content userInteractionEnabled:(BOOL)userInteractionEnabled;

// 显示一个菊花，然后显示一个对勾或一个叉
+ (MBProgressHUD *)showBusyMessage:(NSString *)message timeoutOffset:(NSTimeInterval)timeoutOffset message:(NSString *)timeOutMessage;

+ (MBProgressHUD *)showCheckMarkWithText:(NSString *)text;

- (void)setCompletionMessage:(NSString *)message;


@end
