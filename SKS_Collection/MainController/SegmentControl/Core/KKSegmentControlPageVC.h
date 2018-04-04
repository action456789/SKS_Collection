//
//  KKSegmentControlPageVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSegmentControlPageVC;

NS_ASSUME_NONNULL_BEGIN

@protocol KKSegmentControlPageVCDelegate <NSObject>
@optional
/**
 @param vc 翻页回调
 @param from 起始页面index
 @param to 结束页面index
 @param isUserOperate 是否是用户在本控制器中滑动scrollView导致的翻页
 */
- (void)segmentControlPageVC:(KKSegmentControlPageVC *)vc
        pageChangedFromIndex:(NSUInteger)from
                     toIndex:(NSUInteger)to
               isUserOperate:(BOOL)isUserOperate;
@end


@interface KKSegmentControlPageVC : UIViewController

/// when sliding to a page again, whether to replace the old and load a new page controller. YES, to replace the old and load a new.
@property (nonatomic, assign, readonly) BOOL realtimePage;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) id <KKSegmentControlPageVCDelegate> delegate;

- (instancetype)initWithPageCount:(NSInteger)count
                      controllers:(NSMutableArray<__kindof UIViewController *> *)controllers;

/// when not init all page controllers once a time, you need update or add page controller real time when user slide the slider
- (void)updateControllerFromIndex:(NSUInteger)from
                          toIndex:(NSUInteger)to
                   withController:(UIViewController *)controller;

/// 滚到到某个 index
- (void)autoScrollFromIndex:(NSUInteger)from toIndex:(NSUInteger)to animate:(BOOL)animate;

- (void)setCurrentPage:(NSUInteger)page isUserOperate:(BOOL)isScrollManal;

// 当前页
- (NSInteger)currentPageIndex;

@end

@interface KKSegmentControlPlaceholdVC : UIViewController

@end

NS_ASSUME_NONNULL_END
