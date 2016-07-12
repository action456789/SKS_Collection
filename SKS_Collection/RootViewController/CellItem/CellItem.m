//
//  CellItem.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem

+ (instancetype)itemWithName:(NSString *)name objectClass:(Class)objectClass {
    
    CellItem *item  = [[[self class] alloc] init];
    item.name   = name;
    item.objectClass = objectClass;
    
    return item;
}

@end
