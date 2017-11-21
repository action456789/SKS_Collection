//
//  KKSlideTabBarViewController.m
//  KsCollection
//
//  Created by KeSen on 16/5/17.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "KKSegmentControlDemoVC.h"
#import "KKSlideTabBarView.h"
#import "SlideTabBarItemController.h"
#import "Masonry.h"
#import "UIColor+Creator.h"

#import "CommonMacro.h"

#import "KKSegmentControlVC.h"
#import "KKSlideTabBarLayoutAuto.h"

@interface KKSegmentControlDemoVC () <KKSlideTabBarViewDelegate, SlideTabBarItemControllerDelegate, KKSegmentControlVCDelegate>
{
    KKSlideTabBarView *_tabBar;
    
    /// container of item titles
    NSMutableArray<NSString *> *_titles;
    NSCache<NSNumber *, __kindof UIViewController *> *_cache;
}
@end

@implementation KKSegmentControlDemoVC {
    KKSegmentControlVC *segmentVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cache = [[NSCache alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titles = [NSMutableArray arrayWithObjects:@"电影", @"今日热点", @"新闻", @"今日热点今日热", @"今日热点今  ", @"电影", @"电影asdfas", nil];
//    [self _createTabBarView];
    
    KKSegmentControlBaseLayout *layout = [[KKSlideTabBarLayoutAuto alloc] initWithItemTitles:_titles];
    segmentVC = [[KKSegmentControlVC alloc] initWithItemTitles:_titles layout:layout];
    segmentVC.delegate = self;
    [self.view addSubview:segmentVC.view];
    [self addChildViewController:segmentVC];
    [segmentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
    }];
}

#pragma mark - KKSegmentControlVCDelegate
- (UIViewController *)segmentControlVC:(KKSegmentControlVC *)segmentControl viewControllerForPageAtIndex:(NSInteger)index {
    SlideTabBarItemController *controller = [[SlideTabBarItemController alloc] init];
    controller.delegate = self;
    controller.view.backgroundColor = [UIColor kk_randomColor];
    return controller;
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
    KKSegmentControlBaseLayout *layout = [[KKSlideTabBarLayoutAuto alloc] initWithItemTitles:_titles];
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
