//
//  NSBundle+LocalizationSwizzle.m
//  D103Framework
//
//  Created by sen.ke on 2017/11/2.
//  Copyright © 2017年 Rici. All rights reserved.
//

#import "NSBundle+LocalizationSwizzle.h"
#import "NSBundle+Resource.h"
#import "NSObject+Swizzle.h"
#import "NSBundle+Language.h"

@implementation NSBundle (LocalizationSwizzle)

// TODO: 在这里消息swizzle不起作用，等待寻找原因并解决

/**
 调用一次，之后使用 `NSLocalizedString(@"", @"")` 方法时，会优先从名为 `kk_BundleName` 的 Bundle 中加载
 Bundle 中不存在国际化资源时，会使用系统默认方法
 */
+ (void)kk_autoLoadLocalizableInBundle {
    [NSBundle.mainBundle localizedStringForKey:@"" value:@"" table:nil];
    SEL original = @selector(localizedStringForKey:value:table:);
    SEL new = @selector(hook_mj_localizedStringForKey:value:table:);
    [NSBundle kk_swizzleInstanceMethod:original with:new];
}


/**
 第一步. 从名为 `kk_BundleName` 的 Bundle 中加载
 第二步. 如果第一步没有找到相关资源，会使用系统默认方法加载
 */
- (NSString *)hook_mj_localizedStringForKey:(NSString *)key value:(NSString *)value table:( NSString *)tableName {
    // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans"; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            language = @"zh-Hant"; // 繁體中文
        }
    } else {
        language = @"en";
    }

    // 从bundle中查找资源
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle kk_bundleWithName:kk_BundleName] pathForResource:language ofType:@"lproj"]];
    
    if (bundle == nil) { // 使用默认的方法
        return [NSBundle.mainBundle hook_mj_localizedStringForKey:key value:value table:tableName];
    } else { // 替换系统的方法
        value = [bundle hook_mj_localizedStringForKey:key value:value table:tableName];
        return [[NSBundle mainBundle] hook_mj_localizedStringForKey:key value:value table:nil];
    }
}

@end
