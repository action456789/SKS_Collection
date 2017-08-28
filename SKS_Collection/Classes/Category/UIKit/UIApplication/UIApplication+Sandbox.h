//
//  UIApplication+Sandbox.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/28.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Sandbox)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *kk_documentsURL;
@property (nonatomic, readonly) NSString *kk_documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *kk_cachesURL;
@property (nonatomic, readonly) NSString *kk_cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *kk_libraryURL;
@property (nonatomic, readonly) NSString *kk_libraryPath;

@end
