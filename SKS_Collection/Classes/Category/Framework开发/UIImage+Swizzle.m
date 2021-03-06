//
//  UIImage+Swizzle.m
//  D103FrameWorkSourceCode
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 Rici. All rights reserved.
//

#import "UIImage+Swizzle.h"
#import "NSObject+Swizzle.h"
#import "NSBundle+Resource.h"

@implementation UIImage (Swizzle)

// 修改所有的 [UIImage imageNamed:]的实现，改为先从同一项目中的 .bundle 文件中加载，没有再使用系统默认实现加载
+ (void)kk_autoLoadImageInBundle {
    SEL original = @selector(imageNamed:);
    SEL new = @selector(hook_kk_imageWithName:);
    [self kk_swizzleClassMethod:original with:new];
}

// 1. 从 .bundle 中加载图片
// 2. 按照默认的方法加载图片
+ (instancetype)hook_kk_imageWithName:(NSString *)imageName {
    UIImage *image = [NSBundle kk_imageInBundle:kk_BundleName imageName:imageName];
    if (!image) {
        image = [self hook_kk_imageWithName:imageName];
    }
    
    return image;
}

@end
