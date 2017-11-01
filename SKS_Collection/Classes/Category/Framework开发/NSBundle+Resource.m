//
//  NSBundle+Image.m
//  D103Framework
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 Rici. All rights reserved.
//

#import "NSBundle+Resource.h"

@implementation NSBundle (Resource)

#pragma mark - 访问同一 Target 下 .bundle 的资源文件



/**
 根据 Bundle 名称返回 NSBundle 对象,
 */
+ (NSBundle *)kk_bundleWithName:(NSString *)name {
    //    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:targetName withExtension:@"bundle"]];
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:name ofType: @"bundle"]];
}

/**
 获取 Bundle 中资源文件路径
 */
+ (NSString *)kk_pathInBundle:(NSString *)bundleName withAssetName:(NSString *)assetName {
    NSBundle *myBundle = [self kk_bundleWithName:bundleName];
    if (myBundle && assetName) {
        return [[myBundle resourcePath] stringByAppendingPathComponent: assetName];
    }
    
    return nil;
}

/**
 从 Bundle 中加载图片
 不带 @2x 也能正确加载
 */
+ (UIImage *)kk_imageInBundle:(NSString *)bundleName imageName:(NSString *)imageName {
    NSString *path = [self kk_pathInBundle:bundleName withAssetName:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    // 下面的方法也可以
//    UIImage *image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
