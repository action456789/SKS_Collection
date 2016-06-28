//
//  KSPhotoKit.h
//  KsCollection
//
//  Created by KeSen on 16/2/19.
//  Copyright © 2016年 KeSen. All rights reserved.
//

// 苹果官方代码参见 https://developer.apple.com/library/ios/samplecode/UsingPhotosFramework/Introduction/Intro.html#//apple_ref/doc/uid/TP40014575

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface KSPhotoTool : NSObject

typedef void (^success)();
typedef void (^failure)(NSError *error);

// 创建一个相册，存在时直接返回
- (PHAssetCollection *)collectionWithName:(NSString *)name;

// 保存一张照片到某个相册中
- (void)saveImage:(UIImage *)image inAsesetCollection:(PHAssetCollection *)collection success:(success)saveSuccess failure:(failure)saveFailure;

// 获取所有照片
- (NSArray *)allImages;

// 获取某个相册里的所有照片
- (NSArray *)imagesInAssetCollection:(PHAssetCollection *)collection;

// 获取最新的一张照片
- (UIImage *)latestImage;

// 所有的智能相册
- (PHFetchResult *)allSmartCollections;

// 所有用户创建的相册
- (PHFetchResult *)allUserCollections;

- (PHFetchResult *)allAsserts;

@end
