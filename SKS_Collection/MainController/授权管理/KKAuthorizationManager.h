//
//  AuthorizationManager.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/8/16.
//  Copyright © 2017年 ke sen. All rights reserved.
//  需要 iOS8 以上版本

/*
 <key>NSCameraUsageDescription</key>
 <string>需要您的同意才能访问相机</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>需要您的同意才能访问相册</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>需要您的同意才能访问麦克风</string>
 <key>NSContactsUsageDescription</key>
 <string>需要您的同意才能访问您的联系人</string>
 */

#import <Foundation/Foundation.h>

@interface KKAuthorizationManager : NSObject

/**
 *  检测麦克风权限，仅支持iOS7.0以上系统
 *
 *  @return 准许返回YES;否则返回NO
 */
+(BOOL)isMicrophonePermissionGranted;

/**
 *  检测相机权限
 *
 *  @return 准许返回YES;否则返回NO
 */
+ (BOOL)isCameraPermissionGranted;

/**
 *  检测相册权限
 *
 *  @return 准许返回YES;否则返回NO
 */
+ (BOOL)isAssetsLibraryPermissionGranted;

@end
