//
//  StaticCellItem.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellItem.h"

@implementation StaticCellItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon type:(StaticCellType)type
{
    StaticCellItem *item  = [[[self class] alloc] init];
    item.title = title;
    item.cellType = type;
    item.icon = icon;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon objectClass:(Class)objectClass
{
    StaticCellItem *item = [[self class] itemWithTitle:title icon:icon type:StaticCellTypeDisclosureIndicator];
    item.objectClass = objectClass;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon type:(StaticCellType)type handle:(StaticCellHandle)handle;
{
    StaticCellItem *item = [[self class] itemWithTitle:title icon:icon type:type];
    item.clickedHandle = handle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon subTitle:(NSString *)subTitle
{
    StaticCellItem *item = [[self class] itemWithTitle:title icon:icon type:StaticCellTypeLabel];
    item.subTitle = subTitle;
    
    return item;
}

@end
