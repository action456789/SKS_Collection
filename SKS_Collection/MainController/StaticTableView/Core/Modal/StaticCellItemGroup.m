//
//  StaticCellItemGroup.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellItemGroup.h"

@implementation StaticCellItemGroup

+ (instancetype)itemGroupWithHeaderTitle:(NSString *)headerTitle
                            headerHeight:(CGFloat)headerHeight
                             footerTitle:(NSString *)footerTitle
                            footerHeight:(CGFloat)footerHeight
                                   items:(NSArray *)items
{
    StaticCellItemGroup *group = [[StaticCellItemGroup alloc] init];
    group.headerTitle = headerTitle;
    group.footerTitle = footerTitle;
    group.headerHeight = headerHeight;
    group.footerHeight = footerHeight;
    group.items = items;
    
    return group;
}

@end
