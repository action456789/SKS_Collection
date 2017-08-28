//
//  UIDevice+DeviceInfo.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/28.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceInfo)

#pragma mark - Device Information
///=============================================================================
/// @name Device Information
///=============================================================================

/// Device system version (e.g. 8.1)
+ (double)systemVersion;

/// Whether the device is iPad/iPad mini.
@property (nonatomic, readonly) BOOL kk_isPad;

/// Whether the device is a simulator.
@property (nonatomic, readonly) BOOL kk_isSimulator;

/// Whether the device is jailbroken. 是否越狱
@property (nonatomic, readonly) BOOL kk_isJailbroken;

/// Wherher the device can make phone calls.
@property (nonatomic, readonly) BOOL kk_canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *kk_machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *kk_machineModelName;

/// The System's startup time.
@property (nonatomic, readonly) NSDate * _Nullable kk_systemUptime;

@end
