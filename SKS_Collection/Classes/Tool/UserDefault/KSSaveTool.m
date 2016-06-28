//
//  KSSaveTool.m
//  KSCollects
//
//  Created by KeSen on 15/10/9.
//  Copyright © 2015年 KeSen. All rights reserved.
//  保存到 standardUserDefaults 工具类

#import "KSSaveTool.h"

@implementation KSSaveTool

+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)objectForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

@end
