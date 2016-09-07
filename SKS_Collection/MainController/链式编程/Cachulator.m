//
//  Cachulator.m
//  SKS_Collection
//
//  Created by KeSen on 9/7/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "Cachulator.h"

@implementation Cachulator

- (instancetype)init {
    if (self = [super init]) {
        self.result = 0;
    }
    return self;
}

- (CachulatorBlock)add
{
    return ^id(CGFloat num) {
        self.result += num;
        return self;
    };
}

- (CachulatorBlock)minus
{
    return ^id(CGFloat num) {
        self.result -= num;
        return self;
    };
}

- (CachulatorBlock)multiply
{
    return ^id(CGFloat num) {
        self.result *= num;
        return self;
    };
}

- (CachulatorBlock)divide
{
    return ^id(CGFloat num) {
        self.result /= num;
        return self;
    };
}

@end
