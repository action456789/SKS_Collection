//
//  StaticCellItem.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellItem.h"

@implementation StaticCellItem

+ (instancetype)itemWithTitle:(NSString *)title type:(StaticCellType)type
{
    StaticCellItem *item  = [[[self class] alloc] init];
    item.title = title;
    item.cellType = type;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title objectClass:(Class)objectClass
{
    StaticCellItem *item = [[self class] itemWithTitle:title type:StaticCellTypeDisclosureIndicator];
    item.objectClass = objectClass;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title handle:(StaticCellHandle)handle
{
    StaticCellItem *item = [[self class] itemWithTitle:title type:StaticCellTypeHandle];
    item.handle = handle;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    StaticCellItem *item = [[self class] itemWithTitle:title type:StaticCellTypeLabel];
    item.subTitle = subTitle;
    
    return item;
}

@end
