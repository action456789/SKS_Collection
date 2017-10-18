//
//  StaticCellItem.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, StaticCellType) {
    StaticCellTypeNone,
    StaticCellTypeCheckMark,
};

typedef NS_ENUM(NSInteger, StaticCellSwitchValue) {
    StaticCellSwitchValueNone = -2, // 非开关类型
    StaticCellSwitchValueDefault = -1, // default，根据上次的值获取（存储在沙盒中）
    StaticCellSwitchValueOff, // 0 关
    StaticCellSwitchValueOn, // 1 开
};

#define kStaticCellUpdataNofication @"kStaticCellUpdataNofication"

@interface StaticCellItem : NSObject

typedef void (^kk_CellHandle)(NSIndexPath *indexPath);
typedef void (^kk_CellLeftScrollDeleteHandle)(NSIndexPath *indexPath);

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *iconPlaceHolder;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) NSMutableAttributedString *detailAttributeString;

@property (nonatomic, strong) UIImage *rightContentImage;
@property (nonatomic, strong) UIButton *rightContentButton;

/// cell 的 尺寸，宽度用于设置 Cell 右边视图的位置，高度用于设置 cell 的高度
@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, assign) BOOL isShowIndicator;

@property (nonatomic, copy) kk_CellHandle clickedHandle;

@property (nonatomic, strong) Class objectClass;

@property (nonatomic, assign) StaticCellType cellType;

// 自定义 TalbleViewCell 内容，此时 item.cellType 必须为 StaticCellTypeCustomer
@property (nonatomic, strong) UIView *customerView;

// 左划删除
@property (nonatomic, copy) kk_CellLeftScrollDeleteHandle deleteHandle;

// 开关默认值
@property (nonatomic, assign) StaticCellSwitchValue switchValue;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon objectClass:(Class)objectClass;

- (BOOL)isSwitchOn;

@end
