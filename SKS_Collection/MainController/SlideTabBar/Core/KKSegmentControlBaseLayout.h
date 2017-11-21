//
//  KKSlideTabBarBaseLayout.h
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

static const CGFloat kSTBTopViewHeight          = 45;
static const CGFloat kSTBFirstItemLeftPadding   = 5;
static const CGFloat kSTBLastItemRightPadding   = 5;
static const CGFloat kSTBItemHorizontalSpace    = 15;
static const CGFloat kSTBItemMoreWidth          = 0;
static const CGFloat kSTBItemLineLeftOverWidtht = 5;
static const CGFloat kSTBItemHeightRatio        = 0.9f;

static const CGFloat kSTBItemFontSize           = 14;

static const CGFloat kSTBSperaterWidth          = 0.5;
static const CGFloat kSTBSperaterHeight          = 18;

#define STB_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define STB_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kSTBColorWithHex(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
    blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define kSTBBarBgColor 0x292e37
#define kSTBBottomBgColor 0x1f232a
#define kSTBItemLineBgColor 0xff7608
#define kSTBItemFontColor 0x808080
#define kSTBSeperaterColor 0x808080

@interface KKSegmentControlBaseLayout : NSObject

@property (nonatomic, strong) NSMutableArray<NSNumber *> *itemStringWidths;
@property (nonatomic, strong) NSArray<NSString *> *itemTitles;
@property (nonatomic, assign) BOOL itemScrollViewScrollEnable;
@property (nonatomic, assign) BOOL showSeperater;

- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles;

- (void)layoutItemsViews:(NSArray *)views;
- (CGFloat)lineWidthWithIndex:(NSInteger)index;

@end
