//
//  UITraitCollection+SizeClass.h
//  KsCollection
//
//  Created by KeSen on 16/3/4.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITraitCollection (SizeClass)

/**
 *  sizeclass
 */
//表示 iphone 手机所有机型竖屏
#define isIphonePortrait(newCollection) ((newCollection).horizontalSizeClass == UIUserInterfaceSizeClassCompact && (newCollection).verticalSizeClass == UIUserInterfaceSizeClassRegular)

//表示 iphone手机所有机型横屏  除了iphone6 plus
#define isIphoneLandscape(newCollection) ((newCollection).verticalSizeClass == UIUserInterfaceSizeClassCompact && (newCollection).horizontalSizeClass == UIUserInterfaceSizeClassCompact)

//表示 iphone6 plus的横屏状态
#define isIphone6PlusLandscape(newCollection) ((newCollection).verticalSizeClass == UIUserInterfaceSizeClassCompact && (newCollection).horizontalSizeClass == UIUserInterfaceSizeClassRegular)

//表示 ipad 的横竖屏状态
#define isIpad(newCollection) ((newCollection).verticalSizeClass == UIUserInterfaceSizeClassRegular && (newCollection).horizontalSizeClass == UIUserInterfaceSizeClassRegular)

@end
