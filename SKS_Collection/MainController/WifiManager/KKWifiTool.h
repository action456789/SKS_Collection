//
//  KKWifiTool.h
//  ApartmentLayoutDiagram
//
//  Created by sen.ke on 2017/4/17.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKWifiTool : NSObject

/**
 获取当前连接的wifi的 SSID (即wifi名称)

 @return SSID
 */
+ (NSString *)SSID;

/**
 获取BSSID (手机WLAN中，bssid其实就是无线路由的MAC地址)
 
 @return BSSID
 */
+ (NSString *)BSSID;


/**
 获取SSIDDATA
 SSIDDATA is the hex representation of the SSID. Nothing else, as far as i know.
 
 @return SSIDDATA
 */
+ (NSData *)SSIDDATA;


/**
 获取 WiFi 信息

 @return WiFi
 */
+ (NSDictionary *)wifiInfo;

/**
 获取当前所连接WiFi的网关地址
 例如自己家的路由器一般默认的网关地址是192.168.1.1，获取的就是这个192.168.1.1。<#Description#>

 @return 当前所连接WiFi的网关地址
 */
+ (NSString *)gatewayIp;


/**
 当前设备的ip地址

 @return 当前设备的ip地址
 */
+ (NSString *)localIp;


@end
