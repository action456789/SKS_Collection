//
//  KSPhotoKit.m
//  KsCollection
//
//  Created by KeSen on 16/2/19.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KSPhotoTool.h"

@implementation KSPhotoTool

#pragma mark - 相册
// 创建一个相册
- (PHAssetCollection *)collectionWithName:(NSString *)name {
    
    PHFetchResult *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:name]) {
            return collection;
        }
    }
    
    __block NSString *collectionId = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:name].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        NSLog(@"创建相册【%@】失败 : %@ ", name, error);
        return nil;
    }
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].lastObject;
}

// 获取所有智能相册（系统创建的相册）
- (PHFetchResult *)allSmartCollections {
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    return result;
}

// 获取所有用户创建相册
- (PHFetchResult *)allUserCollections {
    PHFetchResult *result = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    return result;
}

#pragma mark - 照片资源

// 保存一张照片到某个相册中
- (void)saveImage:(UIImage *)image inAsesetCollection:(PHAssetCollection *)collection success:(success)saveSuccess failure:(failure)saveFailure {
    
    if (collection == nil) {
        return;
    }
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusDenied) {
        NSLog(@"请到【设置-隐私-照片】打开访问开关");
        return;
        
    } else if (status == PHAuthorizationStatusRestricted) {
        NSLog(@"无法访问相册");
        return;
        
    } else {
        
        // 保存相片的标识
        __block NSString *assetId = nil;
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                
                NSLog(@"保存失败：%@", error);
            }
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].lastObject;
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection] addAssets:@[asset]];
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    if (saveSuccess) {
                        saveSuccess();
                    }
    
                } else {
                    if (saveFailure) {
                        saveFailure(error);
                    }
                }
            }];
        }];
    }
}

// 获取某个相册里的所有照片
- (NSArray *)imagesInAssetCollection:(PHAssetCollection *)collection {
    NSMutableArray *images = [NSMutableArray array];
    
    // 采取同步获取图片（只获得一次图片）
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = YES;
    
    // 遍历这个相册中的所有图片
    PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    
    for (PHAsset *asset in assetResult) {
        // 过滤非图片
        if (asset.mediaType != PHAssetMediaTypeImage) continue;
        
        // 图片原尺寸
        CGSize targetSize = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        // 请求图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                [images addObject:result];
            }
        }];
    }
    
    return images;
}

- (PHFetchResult *)allAsserts {
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:options];
    return result;
}

// 获取最新的一张照片
- (UIImage *)latestImage {

    // 获取所有照片，按时间排序
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
   
    PHAsset *lastAsset = allPhotos.lastObject;
    __block UIImage *lastImage = nil;
    
    // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片

    // 请求图片
    // 采取同步获取图片（只获得一次图片）
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    // 控制图片质量
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    /**
     *   PHImageRequestOptionsResizeModeExact: 则返回图像必须和目标大小相匹配，并且图像质量也为高质量图像
     *   PHImageRequestOptionsResizeModeFast: 则请求的效率更高，但返回的图像可能和目标大小不一样并且质量较低。
     */
    // imageOptions.deliveryMode: 控制图片质量，如果同时设置了 resizeMode ，以 resizeMode 为准
    // imageOptions.progressHandler: 从 iCloud 下载照片时的下载进度
    imageOptions.synchronous = YES;
    
    [[PHImageManager defaultManager] requestImageForAsset:lastAsset
                                               targetSize:PHImageManagerMaximumSize // 请求的尺寸大于图片原始尺寸时，将返回原始图片
                                              contentMode:PHImageContentModeDefault
                                                  options:imageOptions
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            lastImage = result;
        }
    }];
    
    return lastImage;
}

@end
