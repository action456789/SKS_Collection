//
//  UIAlertController+KS.m
//  KSAlert
//
//  Created by KeSen on 15/12/1.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "UIAlertController+KS.h"

@implementation UIAlertController (KS)

/**
 NSString *title = NSLocalizedString(@"global_alert_starttakeoff", nil);
 NSString *message = @"";
 NSString *cancel  = NSLocalizedString(@"alert_button_cancel", nil);
 NSString *confirm = NSLocalizedString(@"global_alert_select_ok", nil);
 
 NSDictionary *messageDict = @{ @"title"   : title,
    @"message" : message,
    @"cancel"  : cancel,
    @"confirm" : confirm };
 
 UIAlertController *alertVc = [UIAlertController controllerWithPresentedController:self message:messageDict cancelBlock:nil confirmBlock:^{
 
 }];
 */

+ (instancetype)ks_alertControllerWithMessage:(NSDictionary *)dict cancelBlock:(KSAlertBlock)cancelBlock confirmBlock:(KSAlertBlock)confirmBlock; {
    
    NSString *title   = [dict valueForKey:@"title"];
    NSString *message = [dict valueForKey:@"message"];
    NSString *cancel  = [dict valueForKey:@"cancel"];
    NSString *confirm = [dict valueForKey:@"confirm"];
    
    UIAlertController *alert;
    if (title) {
        alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    }
    
    if (cancel && ![cancel isEqual:@""]) {
        [alert addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:cancelBlock]];
    }
    if (confirm && ![confirm isEqual:@""]) {
        [alert addAction:[UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:confirmBlock]];
    }
    
    return alert;
}


@end
