//
//  MBProgressHUD_KS.m
//  HudDemo
//
//  Created by KeSen on 15/9/14.
//  Copyright (c) 2015年 Matej Bukovinski. All rights reserved.
//

#import "MBProgressHUD+KS.h"
#import "KSLayAnimationView.h"
#import <objc/runtime.h>

@implementation MBProgressHUD (KS)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText      = text;

    hud.customView     = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    hud.mode           = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:0.7];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  显示一个背景是否可以与用户交互的 hud
 */
+ (MBProgressHUD *)showMessage:(NSString *)content userInteractionEnabled:(BOOL)userInteractionEnabled {
    
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    
    if (view == nil) {
        return nil;
    }
    
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.mode                      = MBProgressHUDModeText;
    hud.labelText                 = content;
    hud.margin                    = 10.f;
    hud.yOffset                   = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground             = NO;
    hud.userInteractionEnabled    = !userInteractionEnabled;
    
    return hud;
}

- (void)hud:(MBProgressHUD *)hud setText:(NSString *)message {
    
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:1.0];
}

// 显示一个转圈圈的 hud
+ (MBProgressHUD *)showBusyMessage:(NSString *)message timeoutOffset:(NSTimeInterval)timeoutOffset message:(NSString *)timeOutMessage {
    MBProgressHUD *hud = [MBProgressHUD showMessage:message userInteractionEnabled:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.failureFlag = NO;
    
    // 超时设置
    if (timeoutOffset > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeoutOffset * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (hud) {
                hud.labelText = timeOutMessage;
                hud.mode = MBProgressHUDModeCustomView;
                KSLayAnimationView *crossView = [KSLayAnimationView layAnimationView];
                hud.customView = crossView;
                [crossView showWithDuration:0.3f afterDelay:0.2f type:KSLayAnimationTypeCross];
                hud.failureFlag = YES;
                [hud hide:YES afterDelay:1];
            }
        });
    }
    
    return hud;
}

// 设置转圈圈的 hud 任务完成后的信息
- (void)setCompletionMessage:(NSString *)message {
    if (!self || self.failureFlag) {
        return;
    }
    
    CGFloat duration = 1.f;
    
    self.labelText = message;
    self.removeFromSuperViewOnHide = YES;
    self.mode = MBProgressHUDModeCustomView;
    self.failureFlag = NO;
    
    KSLayAnimationView *checkMarkView = [KSLayAnimationView layAnimationView];
    self.customView = checkMarkView;
    [checkMarkView showWithDuration:0.3f afterDelay:0.2f type:KSLayAnimationTypeCheckMark];
    
    [self hide:YES afterDelay:duration];
}

/**
 *  显示一个对勾的 HUD
 */
+ (MBProgressHUD *)showCheckMarkWithText:(NSString *)text {
    
    CGFloat duration = 1.f;
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: view animated: YES];
    hud.labelText = text;
    hud.dimBackground = YES;
    KSLayAnimationView *checkMarkView = [KSLayAnimationView layAnimationView];
    hud.customView = checkMarkView;
    [checkMarkView showWithDuration:0.3f afterDelay:0.2f type:KSLayAnimationTypeCheckMark];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:duration];
    return hud;
}

#pragma mark - getter
- (BOOL)failureFlag {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - setter
- (void)setFailureFlag:(BOOL)failureFlag {
    objc_setAssociatedObject(self, @selector(failureFlag), @(failureFlag), OBJC_ASSOCIATION_RETAIN);
}
@end
