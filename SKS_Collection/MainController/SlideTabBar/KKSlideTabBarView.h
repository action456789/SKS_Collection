//
//  FsSlideTabBarView.h
//  tvcontroller
//
//  Created by KeSen on 16/4/14.
//  Copyright © 2016年 funshon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSlideTabBarView;

@protocol KKSlideTabBarViewDelegate <NSObject>
@optional;
- (void)slideTabBarView:(KKSlideTabBarView *)tabBar pageChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;
- (void)slideTabBarView:(KKSlideTabBarView *)tabBar itemMoreClicked:(UIButton *)itemMore;
@end

@interface KKSlideTabBarView : UIView

/// when sliding to a page again, whether to replace the old and load a new page controller. YES, to replace the old and load a new.
@property (nonatomic, assign, readonly) BOOL realtimePage;

/// if `slideTabBarView` is managed by a viewController, and this viewController is managed by a navigationController, use this property
@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic,weak) id <KKSlideTabBarViewDelegate> delegate;

/// init all items but the array of page controllers is nil
- (instancetype)initWithFrame:(CGRect)frame itemTitles:(NSMutableArray *)itemTitles;

/// designated init, init all items and page controllers once a time
- (instancetype)initWithFrame:(CGRect)frame itemTitles:(NSMutableArray *)itemTitles controllers:(NSMutableArray *)controllers;

- (void)configTabBar;

/// set the current page, and the slider and page controller will slide suitably
- (void)setCurrentPage:(NSUInteger)currentPage withAnimate:(BOOL)animate;

/// when not init all page controllers once a time, you need update or add page controller real time when user slide the slider
- (void)updateControllerFromIndex:(NSUInteger)from toIndex:(NSUInteger)to withController:(UIViewController *)controller;

@end

@interface FsPlaceholdViewController : UIViewController

@end