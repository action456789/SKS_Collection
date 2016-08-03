//
//  StaticCellItemGroup.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StaticCellItem;

@interface StaticCellItemGroup : NSObject

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, strong) NSArray<StaticCellItem *> *items;

+ (instancetype)itemGroupWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle items:(NSArray *)items;

@end
