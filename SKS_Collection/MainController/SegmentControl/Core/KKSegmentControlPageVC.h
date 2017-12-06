//
//  KKSegmentControlPageVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KKSegmentControlPageVC;

@protocol KKSegmentControlPageVCDelegate <NSObject>
@optional
- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc pageChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;
@end


@interface KKSegmentControlPageVC : UIViewController

/// when sliding to a page again, whether to replace the old and load a new page controller. YES, to replace the old and load a new.
@property (nonatomic, assign, readonly) BOOL realtimePage;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) id <KKSegmentControlPageVCDelegate> delegate;

- (instancetype)initWithItemCount:(NSInteger)count
                      controllers:(NSMutableArray<__kindof UIViewController *> *)controllers;

/// when not init all page controllers once a time, you need update or add page controller real time when user slide the slider
- (void)updateControllerFromIndex:(NSUInteger)from
                          toIndex:(NSUInteger)to
                   withController:(UIViewController *)controller;

/// 滚到到某个 index
- (void)autoScrollBottomScrollViewFromIndex:(NSUInteger)from
                                    toIndex:(NSUInteger)to
                                    animate:(BOOL)animate;

/// set the current page, and the slider and page controller will slide suitably
- (void)setCurrentPage:(NSUInteger)currentPage withAnimate:(BOOL)animate;

@end

@interface KKSegmentControlPlaceholdVC : UIViewController

@end
