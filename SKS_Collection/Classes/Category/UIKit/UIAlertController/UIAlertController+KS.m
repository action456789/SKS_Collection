//
//  UIAlertController+KS.m
//  KSAlert
//
//  Created by KeSen on 15/12/1.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "UIAlertController+KS.h"
#import <objc/runtime.h>

@implementation UIAlertController (KS)

/*
 * swift
 let message = ["title" : "注销确认"
 , "message" : "确认注销吗？"
 , "cancel" : "取消"
 , "confirm" : "确认"]
 
 let alert = UIAlertController(message: message, cancel: nil, confirmBlock: {})
 self.present(alert!, animated: true, completion: nil)
 
 * OC
 NSDictionary *msg = @{@"title" : @"提示",
 @"message" : @"没有相机/相册访问权限，请前往系统设置页面开启。",
 @"cancel" : @"取消",
 @"confirm" : @"确认"};
 UIAlertController *alert = [UIAlertController controllerWithMessage:msg cancelBlock:nil confirmBlock:^(UIAlertAction * _Nonnull action) {
 }];
 [self presentViewController:alert animated:YES completion:nil];
 */



+ (instancetype)kk_controllerWithMessage:(NSDictionary *)dict cancelBlock:(KSAlertBlock)cancelBlock confirmBlock:(KSAlertBlock)confirmBlock {
    
    NSString *title   = [dict valueForKey:@"title"];
    NSString *message = [dict valueForKey:@"message"];
    NSString *cancel  = [dict valueForKey:@"cancel"];
    NSString *confirm = [dict valueForKey:@"confirm"];
    
    UIAlertController *alert;
    if (title) {
        alert = [UIAlertController alertControllerWithTitle:title
                                                    message:message
                                             preferredStyle:UIAlertControllerStyleAlert];
    } else {
        return nil;
    }
    
    if (cancel && ![cancel isEqual:@""]) {
        [alert addAction:[UIAlertAction actionWithTitle:cancel
                                                  style:UIAlertActionStyleCancel
                                                handler:cancelBlock]];
    }
    
    if (confirm && ![confirm isEqual:@""]) {
        [alert addAction:[UIAlertAction actionWithTitle:confirm
                                                  style:UIAlertActionStyleDefault
                                                handler:confirmBlock]];
    }
    
    return alert;
}

+ (void)kk_showMessage:(NSString *)message fromViewControler:(UIViewController *)from {
    NSDictionary *msg = @{@"title" : @"提示",
                          @"message" : message,
                          @"confirm" : @"确认"};
    UIAlertController *alert = [UIAlertController kk_controllerWithMessage:msg
                                                               cancelBlock:nil
                                                              confirmBlock:nil];
    [from presentViewController:alert animated:YES completion:nil];
}

@end

