//
//  StaticCollectionViewCellItem.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticCollectionViewCellItem : NSObject

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

@end
