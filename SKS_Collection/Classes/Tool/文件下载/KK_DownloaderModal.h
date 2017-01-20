//
//  KK_DownloaderModal.h
//  KsCollection
//
//  Created by KeSen on 16/4/28.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface KK_DownloaderModal : NSObject

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSURL *url;

@end
