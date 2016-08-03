//
//  StaticCellItemGroup.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellItemGroup.h"

@implementation StaticCellItemGroup

+ (instancetype)itemGroupWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle items:(NSArray *)items
{
    StaticCellItemGroup *group = [[StaticCellItemGroup alloc] init];
    group.headerTitle = headerTitle;
    group.footerTitle = footerTitle;
    group.items = items;
    
    return group;
}

@end
