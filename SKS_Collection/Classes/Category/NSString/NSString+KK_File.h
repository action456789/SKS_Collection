//
//  NSString+KK_File.h
//  KsCollection
//
//  Created by KeSen on 16/4/21.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHomeDirectory NSHomeDirectory()
#define kDocumentDirectory NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#define kLibraryDirectory NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject
#define kCacheDirectory NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTempDirectory NSTemporaryDirectory()

typedef NS_ENUM(NSInteger, KK_SandBox){
    KK_SandBoxDocument,
    KK_SandBoxLibrary,
    KK_SandBoxCaches,
};

@interface NSString (KK_File)

/// 计算文件夹或文件夹的大小, 异步
/// @return size
- (void)countFileOrFold:(NSString *)directory Size:(void (^)(long long size))result;

// create fold in document
- (void)createFoldInSanbox:(KK_SandBox)sanbox Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;
// create file in document
- (void)createFileInDocumentSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;
// delete file or fold
- (void)deleteFileOrFoldSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;
@end
