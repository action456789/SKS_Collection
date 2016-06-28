//
//  Reachability+KS.h
//  ProMap
//
//  Created by KeSen on 15/12/28.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "Reachability.h"

@interface Reachability (KS)
/**
 *  是否WIFI
 */
+ (BOOL)isEnableWIFI;

/**
 *  是否3G
 */
+ (BOOL)isEnable3G;

/**
 *   是否能连接到远程主机
 */
+ (BOOL)isEnableRemoteHost;
@end
