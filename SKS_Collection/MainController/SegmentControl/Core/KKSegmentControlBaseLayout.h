//
//  KKSlideTabBarBaseLayout.h
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "CommonMacro.h"
#import "KKSegmentControlAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKSegmentControlBaseLayout : NSObject

@property (nonatomic, strong) NSMutableArray<NSNumber *> *itemStringWidths;
@property (nonatomic, strong, readonly) NSArray<NSString *> *itemTitles;
@property (nonatomic, strong, readonly) __kindof KKSegmentControlAppearance *config;
@property (nonatomic, assign) BOOL itemScrollViewScrollEnable;
@property (nonatomic, assign) BOOL showSeperater;

- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles
                            config:(__kindof KKSegmentControlAppearance *)config;

- (void)layoutItemsViews:(NSArray *)views;
- (CGFloat)lineWidthWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
