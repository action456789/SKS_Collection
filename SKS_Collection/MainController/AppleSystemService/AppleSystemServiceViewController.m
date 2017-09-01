//
//  AppleSystemServiceViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "AppleSystemServiceViewController.h"
#import "UIDevice+CPU.h"
#import "UIDevice+DiskSpace.h"
#import "UIDevice+DeviceInfo.h"

@implementation AppleSystemServiceViewController {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"磁盘信息");
    NSLog(@"kk_diskSpace: %lld", [UIDevice currentDevice].kk_diskSpace);
    NSLog(@"kk_diskSpaceFree: %lld", [UIDevice currentDevice].kk_diskSpaceFree);
    NSLog(@"kk_diskSpaceUsed: %lld", [UIDevice currentDevice].kk_diskSpaceUsed);
    
    NSLog(@"系统版本");
    NSLog(@"kk_isiOS7Later: %d", [UIDevice kk_isiOS7Later]);
    NSLog(@"kk_isiOS8Later: %d", [UIDevice kk_isiOS8Later]);
    NSLog(@"kk_isiOS9Later: %d", [UIDevice kk_isiOS9Later]);
    NSLog(@"kk_isiOS10Later: %d", [UIDevice kk_isiOS10Later]);
    NSLog(@"kk_isiOS11Later: %d", [UIDevice kk_isiOS11Later]);
    
    NSLog(@"CPU信息");
    NSLog(@"kk_cpuCount: %lu", (unsigned long)[[UIDevice currentDevice] kk_cpuCount]);
    NSLog(@"kk_cpuUsage: %f", [[UIDevice currentDevice] kk_cpuUsage]);
    NSLog(@"kk_cpuUsagePerProcessor: %@", [[UIDevice currentDevice] kk_cpuUsagePerProcessor]);
    
    
}

@end
