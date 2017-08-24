//
//  MBProgressHUD+message.h
//  ApartmentLayoutDiagram
//
//  Created by sen.ke on 2017/4/11.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (message)

+ (void)showText:(NSString *)text icon:(NSString *)icon inView:(UIView *)view;

+ (void)showHud;

+ (void)hideHud;

@end
