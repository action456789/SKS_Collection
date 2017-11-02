//
//  NSBundle+Language.h
//  SmartSocket
//
//  Created by sen.ke on 2017/10/23.
//  Copyright © 2017年 宋旭华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Language)
/**
 @return 用户当前APP使用的语言是否为中文
 */
+ (BOOL)kk_isAppLanguageChinese;

/**
 @return 用户当前APP使用的语言是否为简体中文
 */
+ (BOOL)kk_isAppLanguageSimplifiedChinese;

/**
 @return 用户当前APP使用的语言是否为繁体中文
 */
+ (BOOL)kk_isAppLanguageTraditionalChinese;

@end
