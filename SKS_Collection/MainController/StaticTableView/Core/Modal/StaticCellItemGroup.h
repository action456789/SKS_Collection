//
//  StaticCellItemGroup.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCellItem;

@interface StaticCellItemGroup : NSObject

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GroupType) {
    GroupTypeNone,
    GroupTypeSingleCheckMark, // 单选
    GroupTypeSingleCheckMarkCanCancle, // 单选，再次选择时会取消选择
    GroupTypeMultipleCheckMark, // 多选
};

typedef void (^DidSelectedRowBlock)(NSArray<NSIndexPath *> *selectedIndexPaths);

@property (nonatomic, copy) NSString * _Nullable headerTitle;
@property (nonatomic, copy) NSString * _Nullable footerTitle;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSArray<StaticCellItem *> *items;

@property (nonatomic, assign) GroupType type;

// 点击了 group 中某个 cell 时执行
@property (nonatomic, copy) DidSelectedRowBlock _Nullable didSelectedRowBlock;

// 单选时默认选中的 item
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

// 多选时选中的 item
@property (nonatomic, strong) NSMutableArray<NSIndexPath *> * _Nullable selectedIndexPaths;

+ (instancetype)itemGroupWithItems:(NSArray *)items;

@end

NS_ASSUME_NONNULL_END
