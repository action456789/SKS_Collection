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

// 加载 Localizable.strings
#undef NSLocalizedString
#define NSLocalizedString(key, comment) \
[[NSBundle kk_bundleWithName:kk_BundleName] localizedStringForKey:(key) value:@"" table:nil]

@interface NSBundle (Resource)

+ (NSBundle *)kk_bundleWithName:(NSString *)name;

+ (NSString *)kk_pathInBundle:(NSString *)bundleName withAssetName:(NSString *)assetName;

+ (UIImage *)kk_imageInBundle:(NSString *)bundleName imageName:(NSString *)imageName;

@end
