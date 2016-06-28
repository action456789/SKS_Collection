//
//  KK_Downloader.m
//  KsCollection
//
//  Created by KeSen on 16/4/25.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KK_Downloader.h"
#import "KK_DownloaderModal.h"
#import <AFNetworking.h>

@interface KK_Downloader()

@property (nonatomic, strong) NSMutableDictionary *ongoingTasksDict;
@property (nonatomic, strong) NSMutableDictionary *completionTasksDict;

@end

@implementation KK_Downloader


#pragma mark TODO
- (void)addDownloadTaskWithUrl:(NSString *)urlString {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%@", downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"File downloaded to: %@", filePath);
        
        [self.ongoingTasksDict removeObjectForKey:urlString];

    }];
    
    [downloadTask resume];
    [self.ongoingTasksDict setObject:downloadTask forKey:urlString];
}

#pragma mark - getter

- (NSMutableDictionary *)ongoingTasks {
    if (!_ongoingTasksDict) {
        _ongoingTasksDict = [NSMutableDictionary dictionary];
    }
    return _ongoingTasksDict;
}

- (NSMutableDictionary *)completionTasksDict {
    if (!_completionTasksDict) {
        _completionTasksDict = [NSMutableDictionary dictionary];
    }
    return _completionTasksDict;
}

@end
