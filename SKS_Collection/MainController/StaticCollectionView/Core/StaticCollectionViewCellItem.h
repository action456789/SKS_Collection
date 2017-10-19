//
//  StaticCollectionViewCellItem.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCollectionViewCell;

typedef void (^kk_StaticCellHandle)(StaticCollectionViewCell *cell, UIImageView *icon, UILabel *title);

@interface StaticCollectionViewCellItem : NSObject

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title;
- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title handle:(kk_StaticCellHandle)handle;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) NSString *placeHolderImageName; // image 的占位图片
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) kk_StaticCellHandle clickedHandle;

@end
