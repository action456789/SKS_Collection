//
//  UINavigationController+UIKit.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UINavigationController+UIKit.h"

@implementation UINavigationController (UIKit)

- (UIImageView *)findLineView:(UIView*)view{
    if ([view isKindOfClass:[UIImageView class]]&&view.bounds.size.height <= 1.0) {
        return (UIImageView*) view;
    }for (UIImageView *subview in view.subviews) {
        UIImageView *lineview = [self findLineView:subview];
        if (lineview) {
            return lineview;
        }
    }
    return nil;
}

- (UIImageView *)lineView {
    return [self findLineView:self.navigationBar];
}

@end
