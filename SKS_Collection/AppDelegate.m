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
#import "XHLaunchAd.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setURLCache];
    
    [self startMonitoringNetworkReachability];
    
    [self startLanuchAd];
    
    return YES;
}

- (void)startMonitoringNetworkReachability
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)setURLCache
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024  diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

- (void)startLanuchAd
{
    [XHLaunchAd showWithAdFrame:self.window.bounds setAdImage:^(XHLaunchAd *launchAd) {
        
        //未检测到广告数据,启动页停留时间,默认3,(设置4即表示:启动页显示了4s,还未检测到广告数据,就自动进入window根控制器)
        launchAd.noDataDuration = 1;
        
        //图片地址
        NSString *imgUrl2 = @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg";
        //广告停留时间
        NSInteger duration = 6;
        //广告点击跳转链接
        NSString *openUrl = @"http://www.baidu.com";
        
        //2.设置广告数据
        [launchAd setImageUrl:imgUrl2 duration:duration skipType:SkipTypeTimeText options:XHWebImageDefault completed:^(UIImage *image, NSURL *url) {
            //异步加载图片完成回调,若需根据图片尺寸,刷新广告frame,可在这里操作
            //launchAd.adFrame = ...;
        } click:^{
            //广告点击事件
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
        }];
    } showFinish:^{
        //广告展示完成回调,设置window根控制器
        RootViewController *rootVc = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootVc];
        self.window.rootViewController = nav;
    }];
}

@end
