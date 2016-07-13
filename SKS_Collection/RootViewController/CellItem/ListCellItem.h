//
//  CellItem.h
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListCellItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Class objectClass;

+ (instancetype)itemWithName:(NSString *)name objectClass:(Class)objectClass;

@end
