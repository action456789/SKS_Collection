//
//  CellItem.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "ListCellItem.h"

@implementation ListCellItem

+ (instancetype)itemWithName:(NSString *)name objectClass:(Class)objectClass
{
    ListCellItem *item  = [[[self class] alloc] init];
    item.name   = name;
    item.objectClass = objectClass;
    
    return item;
}

@end
