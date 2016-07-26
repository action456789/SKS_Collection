//
//  UIDevice+KS.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (KS)

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 判断是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//#define iOS8 [[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending


// 状态栏高度
#define  StatusBarHeight                   20.f
// 导航栏高度
#define  NavigationBarHeight               44.f
// 标签栏高度
#define  TabbarHeight                      49.f
// 状态栏高度 + 导航栏高度
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)


// 宽度
#define  ScreenWidth    (Landscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
// 高度
#define  ScreenHeight   (Landscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)


#define  Device_iPhone4_4s   (ScreenWidth == 320.f && ScreenHeight == 480.f ? YES : NO)
#define  Device_iPhone5_5s   (ScreenWidth == 320.f && ScreenHeight == 568.f ? YES : NO)
#define  Device_iPhone6      (ScreenWidth == 375.f && ScreenHeight == 667.f ? YES : NO)
#define  Device_iPhone6_plus (ScreenWidth == 414.f && ScreenHeight == 736.f ? YES : NO)


//判断是否为iPhone
#define iPhoneDevice [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
//判断是否为iPad
#define iPadDevice [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

// 判断是否是横屏
#define Landscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

// 设备唯一标识符
#define kDeviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString]

@end
