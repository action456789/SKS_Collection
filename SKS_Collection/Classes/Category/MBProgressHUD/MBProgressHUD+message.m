//
//  MBProgressHUD+message.m
//  ApartmentLayoutDiagram
//
//  Created by sen.ke on 2017/4/11.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "MBProgressHUD+message.h"

@implementation MBProgressHUD (message)

+ (void)showText:(NSString *)text icon:(NSString *)icon inView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO; // 允许用户交互
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.margin = 10.f;
    
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
        hud.mode = MBProgressHUDModeCustomView;
    }
    
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)showHud {
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hideHud {
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
