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
#import "AFNetworking.h"
//#import <XHLaunchAd.h>
#import "KKNotFluentMonitor.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 设置崩溃信息回调
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setURLCache];
    
    [self startMonitoringNetworkReachability];
    
//    [self startLanuchAd];
    
    RootViewController *rootVc = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootVc];
    self.window.rootViewController = nav;
    
    // 检查卡顿
    [KKNotFluentMonitor.sharedInstance startMonitor];
    
    return YES;
}

// 获取异常崩溃信息
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:action456789@163.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
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


/*
- (void)startLanuchAd
{
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 2;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image0.jpg";
    //网络图片缓存机制(只对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开链接
    imageAdconfiguration.openURLString = @"http://www.returnoc.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = ...
    
    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
 */

 
@end
