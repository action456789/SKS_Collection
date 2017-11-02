//
//  NSBundle+Image.h
//  D103Framework
//
//  Created by sen.ke on 2017/10/31.
//  Copyright © 2017年 Rici. All rights reserved.
//

#import <UIKit/UIKit.h>

// 按照 bundle 的名称进行修改
#define kk_BundleName @"D103FrameworkBundle"

// 加载 Bundle 中的国际化语句
#undef NSLocalizedString
#define NSLocalizedString(key, comment) \
[NSBundle mj_localizedStringForKey:(key)]

@interface NSBundle (Resource)

+ (NSBundle *)kk_bundleWithName:(NSString *)name;

+ (NSString *)kk_pathInBundle:(NSString *)bundleName withAssetName:(NSString *)assetName;

+ (UIImage *)kk_imageInBundle:(NSString *)bundleName imageName:(NSString *)imageName;

+ (NSString *)mj_localizedStringForKey:(NSString *)key;

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value;

@end
