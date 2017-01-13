//
//  StaticCellItem.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, StaticCellType) {
    StaticCellTypeDisclosureIndicator,
    StaticCellTypeButton,
    StaticCellTypeSwitch,
    StaticCellTypeLabel,
    StaticCellTypeHandle,
};

#define kStaticCellUpdataNofication @"kStaticCellUpdataNofication"

@interface StaticCellItem : NSObject

typedef void (^StaticCellHandle)(void);

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, copy) StaticCellHandle clickedHandle;

@property (nonatomic, strong) Class objectClass;

@property (nonatomic, assign) StaticCellType cellType;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon type:(StaticCellType)type;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon objectClass:(Class)objectClass;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon type:(StaticCellType)type handle:(StaticCellHandle)handle;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon subTitle:(NSString *)subTitle;

@end
