//
//  UIViewController+VCFromClassName.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/12.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UIViewController+InstanceFromClass.h"

@implementation UIViewController (InstanceFromClass)

// 根据类名得到控制器的实例: 包含从 xib 加载控制器
+ (instancetype)controllerWithClass:(Class)class
{
    // 优先使用同名的 xib 文件初始化 VC
    
    UIViewController *controller = nil;
    
    // fix bug: swift 使用 NSStringFromClass 得到的字符串为 DemoProject.ClassName
    NSString *className = NSStringFromClass(class);
    if ([className rangeOfString:@"."].location != NSNotFound) {
        className = [className substringFromIndex:[className rangeOfString:@"."].location + 1];
    }
    
    if([[NSBundle mainBundle] pathForResource:className ofType:@"nib"] != nil) {
        controller = [[UIViewController alloc] initWithNibName:className bundle:nil];
    } else {
        controller = [class new];
    }
    
    return controller;
}

@end

