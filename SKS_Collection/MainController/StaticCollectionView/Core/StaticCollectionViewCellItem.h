//
//  StaticCollectionViewCellItem.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCollectionViewCell;

NS_ASSUME_NONNULL_BEGIN

typedef void (^kk_StaticCellHandle)(StaticCollectionViewCell *_Nullable cell, UIImageView *_Nullable icon, UILabel *_Nullable title);

@interface StaticCollectionViewCellItem : NSObject

- (instancetype)initWithImageName:(NSString * _Nullable)imageName
                            title:(NSString * _Nullable)title;

- (instancetype)initWithImageName:(NSString * _Nullable)imageName
                            title:(NSString * _Nullable)title
                           handle:(kk_StaticCellHandle _Nullable)handle;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) NSString *placeHolderImageName; // image 的占位图片
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) kk_StaticCellHandle clickedHandle;

@end

NS_ASSUME_NONNULL_END
