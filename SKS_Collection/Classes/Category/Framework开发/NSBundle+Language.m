//
//  NSBundle+Language.m
//  SmartSocket
//
//  Created by sen.ke on 2017/10/23.
//  Copyright © 2017年 宋旭华. All rights reserved.
//

#import "NSBundle+Language.h"

@implementation NSBundle (Language)

+ (BOOL)kk_isAppLanguageChinese {
    NSString *language = [NSLocale preferredLanguages].firstObject;
    return [language hasPrefix:@"zh"];
}

+ (BOOL)kk_isAppLanguageSimplifiedChinese {
    // 如果代码打包为 framework，运行不准，所以使用 preferredLanguages
    //    NSArray *array = [[NSBundle mainBundle] preferredLocalizations];
    //    return [array.firstObject isEqualToString:@"zh-Hans"];
    NSString *language = [NSLocale preferredLanguages].firstObject;
    return [language rangeOfString:@"Hans"].location != NSNotFound;

}

+ (BOOL)kk_isAppLanguageTraditionalChinese {
//    NSArray *array = [[NSBundle mainBundle] preferredLocalizations];
//    return [array.firstObject isEqualToString:@"zh-Hant"];
    NSString *language = [NSLocale preferredLanguages].firstObject;
    return [language rangeOfString:@"Hant"].location != NSNotFound;
}

@end
