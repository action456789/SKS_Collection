//
//  KKCoreLocationManager.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/9/25.
//  Copyright © 2017年 ke sen. All rights reserved.
//

/*
 <key>NSLocationUsageDescription</key>
 <string>需要您的同意才能访问您的位置</string>
 <key>NSLocationAlwaysUsageDescription</key>
 <string>需要您的同意才能访问您的位置</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>需要您的同意才能访问您的位置</string>
*/

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KKLocationAccuracy) {
    // 'None' is not valid as a desired accuracy.
    /** Inaccurate (>5000 meters, and/or received >10 minutes ago). */
    KKLocationAccuracyNone = 0,
    
    // The below options are valid desired accuracies.
    /** 5000 meters or better, and received within the last 10 minutes. Lowest accuracy. */
    KKLocationAccuracyCity,
    /** 1000 meters or better, and received within the last 5 minutes. */
    KKLocationAccuracyNeighborhood,
    /** 100 meters or better, and received within the last 1 minute. */
    KKLocationAccuracyBlock,
    /** 15 meters or better, and received within the last 15 seconds. */
    KKLocationAccuracyHouse,
    /** 5 meters or better, and received within the last 5 seconds. Highest accuracy. */
    KKLocationAccuracyRoom,
};

@interface KKCoreLocationManager : NSObject

singleton_interface(KKCoreLocationManager)

typedef void (^RequestPermissionBlock)(BOOL isGranted);
typedef void (^GeocodedBlock)(CLPlacemark * _Nullable placemark,
                              NSError * _Nullable error);
typedef void (^GeocodedCityNameBlock)(NSString * _Nullable cityName,
                                      NSString * _Nullable administrativeArea,
                                      NSError * _Nullable error);

/// 请求获取位置权限
/// @param accuracy 精度
/// @param response 请求权限结果回调
- (void)requestLocationPermissionWithAccuracy:(KKLocationAccuracy)accuracy
                                     response:(void (^)(BOOL isGranted))response;

/// 获取当前位置地理编码，位置编码中含有城市名称信息， eg: placemark.locality 为"深圳市"
/// @param accuracy 精度
/// @param geocodedBlock 获取的结果回调
/// Discussion:
///  函数内部会调用 requestLocationPermissionWithAccuracy 方法请求权限
- (void)startUpdateLocationWithAccuracy:(KKLocationAccuracy)accuracy
                          geocodedBlock:(GeocodedBlock)geocodedBlock;

/// 获取当前位置城市名称
/// @param geocodedBlock 获取的结果回调
- (void)startUpdateLocationToGetCity:(GeocodedCityNameBlock)geocodedBlock;

@end

NS_ASSUME_NONNULL_END
