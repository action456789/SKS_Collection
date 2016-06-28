//
//  Reachability+KS.m
//  ProMap
//
//  Created by KeSen on 15/12/28.
//  Copyright © 2015年 KeSen. All rights reserved.
//

// 注意：Reachability 是非 arc 的

#import "Reachability+KS.h"

@implementation Reachability (KS)

+ (NSString *)checkNetworkConnectivity
{
    NSString *networkValue;
    
    Reachability *rc = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus internetStatus = [rc currentReachabilityStatus];
    
    if(internetStatus==0)
    {
        networkValue = @"NoAccess";
    }
    else if(internetStatus==1)
    {
        networkValue = @"ReachableViaWiFi";
        
    } else if(internetStatus==2)
    {
        networkValue = @"ReachableViaWWAN";
    }
    else
    {
        networkValue = @"Reachable";
    }
    
    return networkValue;
}

// 是否能连接到远程主机
+ (BOOL)isEnableRemoteHost {
    NSString *netStr = [self checkNetworkConnectivity];
    
    if([netStr isEqualToString:@"NoAccess"]) {
        return NO;
    } else {
        return YES;
    }
}


// 是否WIFI
+ (BOOL)isEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL)isEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

@end
