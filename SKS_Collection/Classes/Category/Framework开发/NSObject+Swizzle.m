//
//  NSObject+Swizzle.m
//  D103FrameWorkSourceCode
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 Rici. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

+ (BOOL)kk_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);

    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    
    return YES;
}

+ (BOOL)kk_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getClassMethod(class, originalSel);
    Method newMethod = class_getClassMethod(class, newSel);
    
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    
    return YES;
}

@end
