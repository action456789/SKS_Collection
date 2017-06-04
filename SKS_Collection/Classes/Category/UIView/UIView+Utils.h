//
//  UIView+Tool.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

//在view下显示阴影
- (void)showShadow:(BOOL)val;

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;

@end
