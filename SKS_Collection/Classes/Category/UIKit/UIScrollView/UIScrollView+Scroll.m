//
//  UIScrollView+Scroll.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UIScrollView+Scroll.h"

@implementation UIScrollView (Scroll)

- (void)kk_scrollToTop {
    [self kk_scrollToTopAnimated:YES];
}

- (void)kk_scrollToBottom {
    [self kk_scrollToBottomAnimated:YES];
}

- (void)kk_scrollToLeft {
    [self kk_scrollToLeftAnimated:YES];
}

- (void)kk_scrollToRight {
    [self kk_scrollToRightAnimated:YES];
}

- (void)kk_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)kk_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)kk_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)kk_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
