//
//  AppDelegate.m
//  SKS_Collection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "BaseNavigationController.h"
#import "NSTimer+BlockSupurt.h"
#import <AFNetworking.h>
#import "AppSharedDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RootViewController *rootVc = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootVc];
    
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setURLCache];
    
    [self startMonitoringNetworkReachability];
    
    return YES;
}

- (void)startMonitoringNetworkReachability
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

//    [NSTimer sks_scheduledTimerWithTimeInterval:2.0f repeats:YES block:^{
//        NSLog(@"\n reachable:%d, \n WiFi:%d, \n WWAN:%d", [AFNetworkReachabilityManager sharedManager].reachable, [AFNetworkReachabilityManager sharedManager].reachableViaWiFi, [AFNetworkReachabilityManager sharedManager].reachableViaWWAN);
//    }];
}

- (void)setURLCache {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:20 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

@end
