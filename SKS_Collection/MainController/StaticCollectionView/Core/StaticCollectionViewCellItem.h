//
//  StaticCollectionViewCellItem.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^StaticCellHandle)(void);

@interface StaticCollectionViewCellItem : NSObject

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;
- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title handle:(StaticCellHandle)handle;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) StaticCellHandle clickedHandle;

@end