//
//  KKSlideTabBarViewController.m
//  KsCollection
//
//  Created by KeSen on 16/5/17.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KKSlideTabBarViewController.h"
#import "KKSlideTabBarView.h"
#import "SlideTabBarItemController.h"
#import "Masonry.h"
#import "UIColor+Creator.h"
#import "KKSlideTabBarLayoutAuto.h"
#import "KKSlideTabBarLayoutBisect.h"

#import "KKSegmentControlHeadVC.h"
#import "CommonMacro.h"

#import "KKSegmentControlPageVC.h"

@interface KKSlideTabBarViewController () <KKSlideTabBarViewDelegate, SlideTabBarItemControllerDelegate, KKSegmentControlPageVCDelegate>
{
    KKSlideTabBarView *_tabBar;
    
    /// container of item titles
    NSMutableArray<NSString *> *_titles;
    NSCache<NSNumber *, __kindof UIViewController *> *_cache;
}
@end

@implementation KKSlideTabBarViewController {
    KKSegmentControlHeadVC *headVC;
    KKSegmentControlPageVC *pageVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cache = [[NSCache alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titles = [NSMutableArray arrayWithObjects:@"电影", @"今日热点", @"新闻", @"今日热点今日热", @"今日热点今  ", @"电影", @"电影asdfas", nil];
//    [self _createTabBarView];
    
    KKSlideTabBarBaseLayout *layout = [[KKSlideTabBarLayoutAuto alloc] initWithItemTitles:_titles];
    headVC = [[KKSegmentControlHeadVC alloc] initWithItemTitles:_titles layout:layout];
    [self.view addSubview:headVC.view];
    [self addChildViewController:headVC];

    headVC.view.frame = CGRectMake(0, 100, kScreenWidth, 80);

//    NSArray *controllers = [self createControllers];
    pageVC = [[KKSegmentControlPageVC alloc] initWithItemCount:_titles.count controllers:nil];
    pageVC.delegate = self;
    [pageVC setCurrentPage:0 withAnimate:NO];
    [self.view addSubview:pageVC.view];
    pageVC.view.frame = CGRectMake(0, 200, kScreenWidth, 200);
    [self addChildViewController:pageVC];

}

# pragma mark KKSegmentControlPageVC delegate

- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc pageChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    NSLog(@"%ld, %ld", (unsigned long)from, (unsigned long)to);
    if (!pageVC.realtimePage) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SlideTabBarItemController *controller = [_cache objectForKey:@(to)];
        if (!controller) {
            controller = [[SlideTabBarItemController alloc] init];
            controller.delegate = self;
            controller.view.frame = self.view.frame;
            controller.view.backgroundColor = [UIColor kk_randomColor];
            [_cache setObject:controller forKey:@(to)];
        }
        [pageVC updateControllerFromIndex:from toIndex:to withController:controller];
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self resetNavBar];
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

- (NSMutableArray *)createControllers
{
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i=0; i<_titles.count; i++) {
        SlideTabBarItemController *controller = [[SlideTabBarItemController alloc] init];
        controller.view.frame = self.view.frame;
        controller.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f green:arc4random_uniform(255.0f)/255.0f blue:arc4random_uniform(255.0f)/255.0f alpha:1];
        [controllers addObject:controller];
    }
    return controllers;
}

- (void)_createTabBarView
{
//    KKSlideTabBarBaseLayout *layout = [[KKSlideTabBarLayoutBisect alloc] initWithItemTitles:_titles];
    KKSlideTabBarBaseLayout *layout = [[KKSlideTabBarLayoutAuto alloc] initWithItemTitles:_titles];
    _tabBar = [[KKSlideTabBarView alloc] initWithFrame:CGRectZero itemTitles:_titles layout:layout];
    _tabBar.delegate = self;
    [_tabBar setCurrentPage:0 withAnimate:NO];
    _tabBar.navigationController = self.navigationController;
    [self.view addSubview:_tabBar];
    
    [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
    }];
}

#pragma mark KKSlideTabBarView Delegate

- (void)slideTabBarView:(KKSlideTabBarView *)tabBar pageChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    NSLog(@"%ld, %ld", (unsigned long)from, (unsigned long)to);
    if (!_tabBar.realtimePage) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SlideTabBarItemController *controller = [_cache objectForKey:@(to)];
        if (!controller) {
            controller = [[SlideTabBarItemController alloc] init];
            controller.delegate = self;
            controller.view.frame = self.view.frame;
            controller.view.backgroundColor = [UIColor kk_randomColor];
            [_cache setObject:controller forKey:@(to)];
        }
        [_tabBar updateControllerFromIndex:from toIndex:to withController:controller];
    });
}

#pragma mark SlideTabBarItemControllerDelegate Delegate

- (void)scrollDown
{
    [self hideNavBar];
}

- (void)scrollUp
{
    [self showNavBar];
}

- (void)hideNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    [UIView animateWithDuration:0.20 animations:^{
        [_tabBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(-24);
            make.bottom.mas_equalTo(self.view);
        }];
        [_tabBar layoutIfNeeded];
    }];
}

- (void)showNavBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    [UIView animateWithDuration:0.20 animations:^{
        [_tabBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_top).offset(20);
        }];
        [_tabBar layoutIfNeeded];
    }];
}

- (void)resetNavBar
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

@end
