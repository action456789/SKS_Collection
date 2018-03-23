//
//  UITableViewCell+Seperator.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UITableViewCell+Seperator.h"

@implementation UITableViewCell (Seperator)

- (void)hidenSeperator {
    // 在 layoutSubviews 中设置才能 100% 有效
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *subview in self.contentView.superview.subviews) {
            if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
                subview.hidden = YES;
            }
        }
    });
}


@end
