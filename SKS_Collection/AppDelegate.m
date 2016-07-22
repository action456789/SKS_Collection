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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RootViewController *rootVc = [RootViewController new];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootVc];
    
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
