//
//  NSObject+Swizzel.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSObject+Swizzel.h"

#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (Swizzel)

+ (BOOL)swizzleInstance:(id)instance method:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(instance);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) {
        NSLog(@"【NSObject (KKSwizzel)】originalMethod or newMethod is nil");
        return NO;
    }
    
    class_addMethod(class,
                    originalSel,
                    class_getMethodImplementation(class, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(class,
                    newSel,
                    class_getMethodImplementation(class, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(class, originalSel),
                                   class_getInstanceMethod(class, newSel));
    return YES;
}

+ (BOOL)swizzleClass:(Class)someClass method:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(someClass, originalSel);
    Method newMethod = class_getInstanceMethod(someClass, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

@end
