//
//  NSObject+Swizzle.h
//  D103FrameWorkSourceCode
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 Rici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (BOOL)kk_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)kk_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end
