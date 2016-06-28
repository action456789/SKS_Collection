//
//  NSString+KK_File.m
//  KsCollection
//
//  Created by KeSen on 16/4/21.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "NSString+KK_File.h"

#define KK_PerformBlock(blockName, ...) \
if (blockName) { \
    blockName (__VA_ARGS__); \
}

@implementation NSString (KK_File)

//返回单个文件的大小
- (long long)fileSize {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self]) {
        return [[manager attributesOfItemAtPath:self error:nil] fileSize];
    }
    return 0;
}

//多线程计算单个文件的大小
- (void)countFileSize:(void (^)(long long size) )result {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager* manager = [NSFileManager defaultManager];
        long long fileSize = 0;
        if ([manager fileExistsAtPath:self]) {
            fileSize = [[manager attributesOfItemAtPath:self error:nil] fileSize];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            result(fileSize);
        });
        
    });
}

//遍历文件夹获得文件夹大小
- (NSString *)folderSize {
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:self]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:self] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [self stringByAppendingPathComponent:fileName];
        folderSize += [fileAbsolutePath fileSize];
    }
    
    // 需要注意:iOS中1G == 1000Mb ==1000 * 1000kb == 1000 * 1000 * 1000b
    if (folderSize >= pow(10, 12)) {
        return [NSString stringWithFormat:@"%.1fTB", folderSize/pow(10, 12)];
    }else if (folderSize >= pow(10, 9)) {
        return [NSString stringWithFormat:@"%.1fGB", folderSize/pow(10, 9)];
    }else if (folderSize >= pow(10, 6)) {
        return [NSString stringWithFormat:@"%.1fMB", folderSize/pow(10, 6)];
    }if (folderSize >= pow(10, 3)) { //KB
        return  [NSString stringWithFormat:@"%fKB", folderSize/pow(10, 3)];
    }else {
        return [NSString stringWithFormat:@"%.1lldB", folderSize];
    }
}

// 多线程计算文件夹的大小
- (void)countFoldSize:(void (^)(long long size))result {
    __block long long size = 0;
    
    // 文件属性
    NSFileManager* manager = [NSFileManager defaultManager];
    
    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];
    // 如果这个文件或者文件夹不存在,或者路径不正确;
    if (attrs == nil) {
        result(0);
    }
    
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) { // 如果是文件夹
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSFileManager* manager = [NSFileManager defaultManager];
            if (![manager fileExistsAtPath:self]) {
                size = 0;
            }
            
            NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:self] objectEnumerator];
            NSString *fileName;
            
            while ((fileName = [childFilesEnumerator nextObject]) != nil) {
                NSString *fileAbsolutePath = [self stringByAppendingPathComponent:fileName];
                size += [fileAbsolutePath fileSize];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result(size);
            });
        });
    }
}

#pragma mark - public method

// 多线程计算文件夹或文件的大小
- (void)countFileOrFold:(NSString *)directory Size:(void (^)(long long size))result {
    NSFileManager* manager = [NSFileManager defaultManager];
    NSDictionary *attrs = [manager attributesOfItemAtPath:self error:nil];

    // is fold
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {
        [self countFoldSize:result];
    } else { // is file
        [self countFileSize:result];
    }
}

// 创建文件夹
- (void)createFoldInSanbox:(KK_SandBox)sanbox Success:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *newFoldDirectory = nil;
    switch (sanbox) {
        case KK_SandBoxDocument: {
            newFoldDirectory = [kDocumentDirectory stringByAppendingPathComponent:self];
            break;
        }
        case KK_SandBoxLibrary: {
            newFoldDirectory = [kLibraryDirectory stringByAppendingPathComponent:self];
            break;
        }
        case KK_SandBoxCaches: {
            newFoldDirectory = [kCacheDirectory stringByAppendingPathComponent:self];
            break;
        }
    }
    NSError *error = nil;
    BOOL result = [fileManager createDirectoryAtPath:newFoldDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (result) {
        KK_PerformBlock(success);
    } else {
        KK_PerformBlock(failure, error);
    }
}

// 创建文件
- (void)createFileInDocumentSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *newFileDirectory = [kDocumentDirectory stringByAppendingPathComponent:self];
    
    NSError *error = nil;
    BOOL result = [fileManager createFileAtPath:newFileDirectory contents:nil attributes:nil];
    if (result) {
        KK_PerformBlock(success);
    } else {
        KK_PerformBlock(failure, error);
    }
}

// 删除文件
- (void)deleteFileOrFoldSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL result = [fileManager removeItemAtPath:self error:&error];
    if (result) {
        KK_PerformBlock(success);
    } else {
        KK_PerformBlock(failure, error);
    }
}

@end
