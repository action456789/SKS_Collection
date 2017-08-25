//
//  UIBarButtonItem+BlockSupport.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UIBarButtonItem+BlockSupport.h"
#import <objc/runtime.h>

static const int block_key;

@interface _YYUIBarButtonItemBlockTarget : NSObject
@property (nonatomic, copy) void (^block)(id sender);
- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;
@end

@implementation _YYUIBarButtonItemBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (self.block) self.block(sender);
}

@end




@implementation UIBarButtonItem (BlockSupport)

- (void)setActionBlock:(void (^)(id sender))block {
    _YYUIBarButtonItemBlockTarget *target = [[_YYUIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTarget:target];
    [self setAction:@selector(invoke:)];
}

- (void (^)(id)) actionBlock {
    _YYUIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}

@end
