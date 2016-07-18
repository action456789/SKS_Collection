//
//  KKSlideTabBarViewController.m
//  KsCollection
//
//  Created by KeSen on 16/5/17.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KKSlideTabBarViewController.h"
#import "KKSlideTabBarView.h"
#import <Masonry.h>

@interface KKSlideTabBarViewController () <KKSlideTabBarViewDelegate>
{
    KKSlideTabBarView *_tabBar;
    
    /// container of item titles
    NSMutableArray<NSString *> *_titles;
    NSCache<NSNumber *, __kindof UIViewController *> *_cache;
}
@end

@implementation KKSlideTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLayoutSubviews
{
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0) { // fix bug: iOS 7 cannot scorll
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tabBar configTabBar];
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [_cache removeAllObjects];
}

- (instancetype)initWithFrame:(CGRect)frame itemTitles:(NSMutableArray *)itemTitles controllers:(NSMutableArray *)controllers
{
    _tabBar = [[KKSlideTabBarView alloc] initWithFrame:self.view.frame itemTitles:itemTitles controllers:controllers];
    _tabBar.delegate = self;
    [_tabBar setCurrentPage:0 withAnimate:NO];
    //_tabBar.navigationController = [FsSharedDataManager sharedInstance].navigationController;
    [self.view addSubview:_tabBar];
    
    [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
    }];
    return self;
}

- (void)slideTabBarView:(KKSlideTabBarView *)tabBar pageChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    NSLog(@"%ld, %ld", (unsigned long)from, (unsigned long)to);
    if (!_tabBar.realtimePage) {
        return;
    }
    
    UIViewController *controller = [_cache objectForKey:@(to)];
    if (!controller) {
        UIViewController *controller = [[UIViewController alloc] init];
        controller.view.frame = self.view.frame;
        controller.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f
                                                          green:arc4random_uniform(255.0f)/255.0f
                                                           blue:arc4random_uniform(255.0f)/255.0f
                                                          alpha:1];
        [_cache setObject:controller forKey:@(to)];
    }
    
    [_tabBar updateControllerFromIndex:from toIndex:to withController:controller];
}

@end
