//
//  KSSerialization.m
//  KSCollects
//
//  Created by KeSen on 15/10/28.
//  Copyright © 2015年 KeSen. All rights reserved.
//  利用runtime自动归档
//  使用方法：需要归档的 modal 继承这个类即可，不需要再实现 NSCoding 里的两个方法

#import "KSSerialization.h"
#import <objc/message.h>

@implementation KSSerialization

// 返回self的所有对象名称
+ (NSArray *)propertyOfSelf{
    unsigned int count = 0;
    
    // 1. 获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        
        [properNames addObject:key];
    }
    
    return [properNames copy];
}

// 归档
- (void)encodeWithCoder:(NSCoder *)enCoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
        // 对每一个属性实现归档
        [enCoder encodeObject:[self performSelector:getSel] forKey:propertyName];
    }
}

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    
    for (NSString *propertyName in properNames) {
        // 创建指向属性的set方法
        // 1.获取属性名的第一个字符，变为大写字母
        NSString *firstCharater = [propertyName substringToIndex:1].uppercaseString;
        // 2.替换掉属性名的第一个字符为大写字符，并拼接出set方法的方法名
        NSString *setPropertyName = [NSString stringWithFormat:@"set%@%@:",firstCharater,[propertyName substringFromIndex:1]];
        SEL setSel = NSSelectorFromString(setPropertyName);
        [self performSelector:setSel withObject:[aDecoder decodeObjectForKey:propertyName]];
    }
    return  self;
}

// 打印时显示所有属性名称
- (NSString *)description{
    NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"\n"];
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
        
        NSString *propertyNameString = [NSString stringWithFormat:@"%@ - %@\n",propertyName,[self performSelector:getSel]];
        [descriptionString appendString:propertyNameString];
    }
    
    return [descriptionString copy];
}


@end
