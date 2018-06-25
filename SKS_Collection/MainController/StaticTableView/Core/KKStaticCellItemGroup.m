//
//  StaticCellItemGroup.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "KKStaticCellItemGroup.h"

@implementation KKStaticCellItemGroup

+ (instancetype)itemGroupWithItems:(NSArray *)items {
    KKStaticCellItemGroup *group = [[KKStaticCellItemGroup alloc] init];
    group.items = items;
    group.headerTitle = nil;
    group.footerTitle = nil;
    group.headerHeight = 0;
    group.footerHeight = 0;
    
    return group;
}

- (NSMutableArray<NSIndexPath *> *)selectedIndexPaths {
    if (_selectedIndexPaths == nil) {
        _selectedIndexPaths = [NSMutableArray array];
    }
    return _selectedIndexPaths;
}

- (void)setDidSelectedRowBlock:(DidSelectedRowBlock)didSelectedRowBlock {
    _didSelectedRowBlock = [didSelectedRowBlock copy];
}


@end
