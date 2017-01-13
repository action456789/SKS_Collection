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

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSArray<StaticCellItem *> *items;

+ (instancetype)itemGroupWithHeaderTitle:(NSString *)headerTitle
                            headerHeight:(CGFloat)headerHeight
                             footerTitle:(NSString *)footerTitle
                            footerHeight:(CGFloat)footerHeight
                                   items:(NSArray *)items;

@end
