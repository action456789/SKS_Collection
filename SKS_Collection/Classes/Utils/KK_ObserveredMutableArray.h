//
//  KK_ObserveredMutableArray.h
//  getOffWorkTime
//
//  Created by KeSen on 16/4/6.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KK_ObserveredMutableArray : NSObject <NSFastEnumeration>

@property (readonly) NSInteger count;
- (NSMutableArray *)array;

- (void)addObject:(id)object;

- (void)removeObject:(id)object;

- (void)addObjectsFromArray:(NSArray *)otherArray;

- (NSUInteger)indexOfObject:(id)anObject;

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

- (id)objectAtIndex:(NSUInteger)index;

// 实现下标操作
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end
