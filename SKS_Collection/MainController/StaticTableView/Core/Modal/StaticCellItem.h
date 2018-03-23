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

NS_ASSUME_NONNULL_BEGIN

typedef void (^kk_CellClickHandle)(NSIndexPath * indexPath);
typedef void (^kk_CellLeftScrollDeleteHandle)(NSIndexPath * indexPath);
typedef void (^kk_CellSwitchValueChangeHandle)(UISwitch * s);

@property (nonatomic, copy) NSString * _Nullable icon;
@property (nonatomic, copy) NSString * _Nullable iconPlaceHolder;
@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, copy) NSString * _Nullable detail;
@property (nonatomic, strong) NSMutableAttributedString *detailAttributeString;

@property (nonatomic, strong) UIImage * _Nullable rightContentImage;
@property (nonatomic, strong) UIButton * _Nullable rightContentButton;

// 是否有点击效果
@property (nonatomic, assign) BOOL isSelectionStyleEnable;

/// cell 的 尺寸，宽度用于设置 Cell 右边视图的位置，高度用于设置 cell 的高度
@property (nonatomic, assign) CGSize cellSize;

@property (nonatomic, assign) BOOL isShowIndicator;

@property (nonatomic, copy) kk_CellClickHandle _Nullable clickedHandle;

@property (nonatomic, strong) Class _Nullable objectClass;

@property (nonatomic, assign) StaticCellType cellType;

// 自定义 TalbleViewCell 内容
@property (nonatomic, strong) UIView *_Nullable customerView;

// 左划删除
@property (nonatomic, copy) kk_CellLeftScrollDeleteHandle deleteHandle;

// 开关默认值
@property (nonatomic, assign) StaticCellSwitchValue switchValue;

// 右边为 Switch 时，UISwitch Value Change 事件回调
@property (nonatomic, copy) kk_CellSwitchValueChangeHandle switchValueChangeHandle;



+ (instancetype)itemWithTitle:(NSString * _Nullable )title
                         icon:(NSString * _Nullable )icon
                  objectClass:(Class _Nullable)objectClass;

- (BOOL)isSwitchOn;

@end

NS_ASSUME_NONNULL_END
