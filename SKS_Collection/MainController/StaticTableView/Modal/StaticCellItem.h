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

@interface StaticCellItem : NSObject

typedef void (^StaticCellHandle)(void);

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) StaticCellHandle clickedHandle;

@property (nonatomic, strong) Class objectClass;

@property (nonatomic, assign) StaticCellType cellType;

+ (instancetype)itemWithTitle:(NSString *)title type:(StaticCellType)type;
+ (instancetype)itemWithTitle:(NSString *)title type:(StaticCellType)type handle:(StaticCellHandle)handle;
+ (instancetype)itemWithTitle:(NSString *)title objectClass:(Class)objectClass;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
@end
