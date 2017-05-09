//
//  StaticCollectionViewCellItem.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionViewCellItem.h"

@implementation StaticCollectionViewCellItem

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title {
    if (self = [super init]) {
        _imageName = imageName;
        _title = title;
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title handle:(StaticCellHandle)handle {
    if (self = [self init]) {
        _imageName = imageName;
        _title = title;
        _clickedHandle = handle;
    }
    return self;
}

@end