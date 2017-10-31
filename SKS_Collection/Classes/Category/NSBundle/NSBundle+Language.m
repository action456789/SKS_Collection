//
//  NSBundle+Language.m
//  SmartSocket
//
//  Created by sen.ke on 2017/10/23.
//  Copyright © 2017年 宋旭华. All rights reserved.
//

#import "NSBundle+Language.h"

@implementation NSBundle (Language)

// https://mjtsai.com/blog/2014/12/09/nslocale-preferredlanguages-vs-nsbundle-preferredlocalizations/
+ (BOOL)kk_isAppLanguageChinese {
    NSArray *array = [[NSBundle mainBundle] preferredLocalizations];
    return [array.firstObject isEqualToString:@"zh-Hans"];
}

@end
