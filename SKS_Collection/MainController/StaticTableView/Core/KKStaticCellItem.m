//
//  StaticCellItem.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "KKStaticCellItem.h"

@implementation KKStaticCellItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon type:(KKStaticCellType)type {
    KKStaticCellItem *item  = [[[self class] alloc] init];
    item.icon = icon;
    item.title = title;
    item.detail = nil;
    item.isShowIndicator = YES;
    item.clickedHandle = nil;
    item.objectClass = nil;
    item.switchValue = KKStaticCellSwitchValueNone;
    item.cellType = type;
    item.isSelectionStyleEnable = YES;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon objectClass:(Class)objectClass {
    KKStaticCellItem *item = [[self class] itemWithTitle:title icon:icon type:KKStaticCellTypeNone];
    item.objectClass = objectClass;

    return item;
}

- (BOOL)isSwitchOn {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:self.title];
}

- (void)setClickedHandle:(kk_CellClickHandle)clickedHandle {
    _clickedHandle = [clickedHandle copy];
}

- (void)setSwitchValueChangeHandle:(kk_CellSwitchValueChangeHandle)switchValueChangeHandle {
    _switchValueChangeHandle = [switchValueChangeHandle copy];
}

@end
