//
//  KK_ObserveredMutableArray.m
//  getOffWorkTime
//
//  Created by KeSen on 16/4/6.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KK_ObserveredMutableArray.h"

@interface KK_ObserveredMutableArray() {
    
    NSMutableArray *_array;
}

@end

@implementation KK_ObserveredMutableArray

- (instancetype)init {
    if (self = [super init]) {
        _array = [NSMutableArray array];
    }
    return self;
}

/**
 @discussion 只有通过 KVO 的方式获取 array 对象，才会触发监听数组内容变化通知。
 @warning 如果声明 array 为 property，在 get 方法中调用 mutableArrayValueForKey 方法将会触发死循环。
 */
- (NSMutableArray *)array {
    return [self mutableArrayValueForKey:@"array"];
}

- (void)addObject:(id)object {
    [[self array] addObject:object];
}

- (void)removeObject:(id)object {
    [[self array] removeObject:object];
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    [[self array] addObjectsFromArray:otherArray];
}

- (NSUInteger)indexOfObject:(id)anObject {
    return [[self array] indexOfObject:anObject];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [[self array] insertObject:anObject atIndex:index];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [[self array] objectAtIndex:index];
}

#pragma mark - 实现下标操作
- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self array][idx];
}
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    [self array][idx] = obj;
}

#pragma mark - getter 

- (NSInteger)count {
    return _array.count;
}

/**
 @discussion 要有 for in 表达式的功能，必须要实现 NSFastEnumeration 协议
 */
#pragma mark - NSFastEnumeration delegate
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [[self array] countByEnumeratingWithState:state objects:buffer count:len];
}

- (NSString *)description {
    NSString *str = @"";
    for (id obj in _array) {
        str = [str stringByAppendingString:@"\n"];
        str = [str stringByAppendingString:[NSString stringWithFormat:@"----%@", obj]];
    }
    return str;
}

@end
