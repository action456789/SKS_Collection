//
//  KKWifiTool.m
//  ApartmentLayoutDiagram
//
//  Created by sen.ke on 2017/4/17.
//  Copyright © 2017年 ke sen. All rights reserved.
//0

#import "KKWifiTool.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <arpa/inet.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import "getgateway.h"
#import "CommonMacro.h"

@implementation KKWifiTool

+ (NSString *)SSID {
    NSDictionary *info = [[KKWifiTool class] wifiInfo];
    if (info) {
        // WiFiName = [info objectForKey:@"SSID"];
        return [info objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
    }
    return nil;
}

// 网关 mac 地址 (手机WLAN中，bssid其实就是无线路由的MAC地址)
+ (NSString *)BSSID {
    NSDictionary *info = [[KKWifiTool class] wifiInfo];
    if (info) {
        return [info objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
    }
    return nil;
}

// SSIDDATA is the hex representation of the SSID. Nothing else, as far as i know.
// https://stackoverflow.com/questions/19723100/what-ssiddata-in-ios-contains
+ (NSData *)SSIDDATA {
    NSDictionary *info = [[KKWifiTool class] wifiInfo];
    if (info) {
        return [info objectForKey:(__bridge NSData *)kCNNetworkInfoKeySSIDData];
    }
    return nil;
}

// 当前设备的ip地址
+ (NSString *)localIp {
    NSMutableDictionary *dict = [[self class] wlanInfo];
    if (IsValidateDic(dict)) {
        NSString *localIp = dict[@"localIp"];
        if (IsValidateString(localIp)) {
            return localIp;
        }
    }
    return @"127.0.0.1";
}

// 获取当前所连接WiFi的网关地址
// 例如自己家的路由器一般默认的网关地址是192.168.1.1，获取的就是这个192.168.1.1。
+ (NSString *)gatewayIp {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        //*/
        while(temp_addr != NULL) {
            /*/
             int i=255;
             while((i--)>0)
             //*/
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String //ifa_addr
                    //ifa->ifa_dstaddr is the broadcast address, which explains the "255's"
                    //                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    in_addr_t i = inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t* x = &i;
    
    unsigned char *s = getdefaultgateway(x);
    NSString *ip=[NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
    free(s);
    return ip;
}

//获取 WiFi 信息，返回的字典中包含了WiFi的名称、路由器的Mac地址、还有一个Data(转换成字符串打印出来是wifi名称)
// 真机有效，模拟器无效
/*
 {"SSID": RICI-BGQ,
 "BSSID": a4:56:2:15:3b:57,
 "SSIDDATA": <52494349 2d424751>
 }
 */
+ (NSDictionary *)wifiInfo {
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info;
}

// 获取广播地址、本机地址、子网掩码、端口
/*
 wifi:{
 broadcast = "192.168.1.255";
 interface = en0;
 localIp = "192.168.1.7";
 netmask = "255.255.255.0";
 }
*/
+ (NSMutableDictionary *)wlanInfo {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        //*/
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    //----192.168.1.255 广播地址
                    NSString *broadcast = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    if (broadcast) {
                        [dict setObject:broadcast forKey:@"broadcast"];
                    }
                    
                    //--192.168.1.106 本机地址
                    NSString *localIp = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    if (localIp) {
                        [dict setObject:localIp forKey:@"localIp"];
                    }
                    
                    //--255.255.255.0 子网掩码地址
                    NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    if (netmask) {
                        [dict setObject:netmask forKey:@"netmask"];
                    }
                    
                    //--en0 端口地址
                    NSString *interface = [NSString stringWithUTF8String:temp_addr->ifa_name];
                    if (interface) {
                        [dict setObject:interface forKey:@"interface"];
                    }
                    
                    return dict;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return dict;
}

@end
