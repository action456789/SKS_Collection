//
//  KKSlideTabBarBaseLayout.h
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "CommonMacro.h"

static const CGFloat SegmentControl_HeaderViewHeight          = 45;
static const CGFloat SegmentControl_HeaderFirstItemLeftPadding   = 5;
static const CGFloat SegmentControl_HeaderLastItemRightPadding   = 5;
static const CGFloat SegmentControl_HeaderItemHorizontalSpace    = 15;
static const CGFloat SegmentControl_HeaderItemMoreWidth          = 0;
static const CGFloat SegmentControl_HeaderItemLineLeftOverWidtht = 5;
static const CGFloat SegmentControl_HeaderItemHeightRatio        = 0.9f;

static const CGFloat SegmentControl_HeaderItemFontSize           = 14;

static const CGFloat SegmentControl_HeaderSperaterWidth          = 0.5;
static const CGFloat SegmentControl_HeaderSperaterHeight          = 18;

#define SegmentControl_HeaderBackgroundColor [UIColor clearColor]
#define SegmentControl_HeaderItemLineBgColor kColorWithHex(0xff7608)
#define SegmentControl_HeaderItemFontNormalColor kColorWithHex(0xFFFFFF)
#define SegmentControl_HeaderItemFontSelectedColor kColorWithHex(0x33C47C)
#define SegmentControl_HeaderItemSeperaterColor kColorWithHex(0x808080)
#define SegmentControl_HeaderSliderColor kColorWithHex(0x33C47C)

#define SegmentControl_PageBackgroundColor [UIColor clearColor]

@interface KKSegmentControlBaseLayout : NSObject

@property (nonatomic, strong) NSMutableArray<NSNumber *> *itemStringWidths;
@property (nonatomic, strong) NSArray<NSString *> *itemTitles;
@property (nonatomic, assign) BOOL itemScrollViewScrollEnable;
@property (nonatomic, assign) BOOL showSeperater;

- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles;

- (void)layoutItemsViews:(NSArray *)views;
- (CGFloat)lineWidthWithIndex:(NSInteger)index;

@end
