//
//  UIScrollView+Scroll.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Scroll)

/**
 Scroll content to top with animation.
 */
- (void)kk_scrollToTop;

/**
 Scroll content to bottom with animation.
 */
- (void)kk_scrollToBottom;

/**
 Scroll content to left with animation.
 */
- (void)kk_scrollToLeft;

/**
 Scroll content to right with animation.
 */
- (void)kk_scrollToRight;

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)kk_scrollToTopAnimated:(BOOL)animated;

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)kk_scrollToBottomAnimated:(BOOL)animated;

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)kk_scrollToLeftAnimated:(BOOL)animated;

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)kk_scrollToRightAnimated:(BOOL)animated;

@end
