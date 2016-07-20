//
//  SlideTabBarDemo.m
//  SKS_Collection
//
//  Created by KeSen on 7/18/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "SlideTabBarDemoController.h"
#import "KKSlideTabBarViewController.h"

@interface SlideTabBarDemoControllerM

@end

@implementation SlideTabBarDemoController
{
    KKSlideTabBarViewController *_tabBarVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *titles = [NSMutableArray arrayWithObjects:@"电影", @"今日热点", @"新闻", @"今日热点今日热", @"今日热点今日热点  ", @"电影", @"电影asdfas", nil];
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        UIViewController *controller = [[UIViewController alloc] init];
        controller.view.frame = self.view.frame;
        controller.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f green:arc4random_uniform(255.0f)/255.0f blue:arc4random_uniform(255.0f)/255.0f alpha:1];
        [controllers addObject:controller];
    }
    _tabBarVc = [[KKSlideTabBarViewController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) itemTitles:titles controllers:controllers];
    
    [self.view addSubview:_tabBarVc.view];
}

@end
