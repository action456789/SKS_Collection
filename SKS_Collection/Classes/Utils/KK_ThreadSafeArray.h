//
//  KK_ThreadSafeArray.h
//  KsCollection
//
//  Created by KeSen on 16/4/25.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KK_ThreadSafeArray : NSObject <NSFastEnumeration>

+ (instancetype)array;

- (instancetype)initWithArray:(NSMutableArray *)otherArray;

- (void)addObject:(id)object;

- (void)removeObject:(id)object;

- (NSUInteger)indexOfObject:(id)anObject;

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

- (id)objectAtIndex:(NSUInteger)index;

- (KK_ThreadSafeArray *)sortedArrayUsingSelector:(SEL)comparator;

// implement subscript operation
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end
