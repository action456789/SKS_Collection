//
//  NSArray+SafeAccess.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/24.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)kk_randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)kk_objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

@end



@implementation NSMutableArray (SafeAccess)

- (void)kk_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)kk_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

- (id)kk_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self kk_removeFirstObject];
    }
    return obj;
}

- (id)kk_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)kk_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)kk_shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

#pragma clang diagnostic pop

@end
