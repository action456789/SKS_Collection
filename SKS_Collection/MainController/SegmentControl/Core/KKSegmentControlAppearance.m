//
//  KKSegmentControlConfig.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "KKSegmentControlAppearance.h"
#import "CommonMacro.h"

@implementation KKSegmentControlAppearance

- (CGFloat)headerViewHeight {
    return 40.f;
}

- (CGFloat)headerViewWidth {
    return kScreenWidth;
}
    
- (UIColor *)headerBackgroundColor {
    return [UIColor blackColor];
}

- (SegmentControlSlidePosition)slidePosition {
    return SegmentControlSlidePositionBottom;
}

- (BOOL)isShowSlide {
    return YES;
}

- (CGFloat)slideHeight {
    return 2.f;
}

- (CGFloat)slideWidth {
    return 50;
}

- (CGFloat)slideTopPaddingForItem {
    return 0;
}

- (BOOL)isSlideWidthAuto {
    return YES;
}

- (CGFloat)slideLeftRightOverWidth {
    return 10.f;
}

- (CGFloat)firstItemLeftPadding {
    return self.slideLeftRightOverWidth;
}

- (CGFloat)lastItemRightPadding {
    return self.slideLeftRightOverWidth;
}

- (CGFloat)itemHorizontalSpace {
    return 30;
}

- (CGFloat)itemMoreWidth {
    return 0;
}

- (CGFloat)itemHeightRatio {
    return 0.9;
}

- (CGFloat)itemFontSize {
    return 14.f;
}

- (CGFloat)itemSeperaterWidth {
    return 0.5f;
}

- (CGFloat)itemSperaterHeight {
    return 18.f;
}

- (UIColor *)itemSperaterBgColor {
    return kColorWithHex(0xff7608);
}

- (UIColor *)itemFontNormalColor {
    return kColorWithHex(0xFFFFFF);
}

- (UIColor *)itemFontSelectedColor {
    return kColorWithHex(0x33C47C);
}

- (UIColor *)itemSeperaterColor {
    return kColorWithHex(0x808080);
}

- (CGFloat)itemSelectedTransformScaleX {
    return 1.1;
}

- (CGFloat)itemSelectedTransformScaleY {
    return 1.1;
}

- (CGFloat)slideTransformScaleX {
    return 1.1;
}

- (CGFloat)slideTransformScaleY {
    return 1.1;
}

- (UIColor *)sliderColor {
    return kColorWithHex(0x33C47C);
}

- (CGFloat)pageViewInsectWithHeadView {
    return 0;
}

- (UIColor *)pageBackgroundColor {
    return [UIColor clearColor];
}

@end
