//
//  UINavigationController+SubView.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/9/6.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UINavigationController+SubView.h"
#import "UIView+UIKit.h"

@implementation UINavigationController (SubView)

// 获取导航栏底部的横线
- (UIImageView *)kk_lineView {
    return [UIView kk_findLineView:self.navigationBar];
}

// 获取导航栏底部的横线
- (UIImageView *)kk_navbarImageView {
    UIImageView *imageView = (UIImageView *)[self.navigationBar.subviews firstObject];
    return imageView;
}

// 设置导航栏的alpha值
- (void)setKk_alpha:(CGFloat)kk_alpha {
    UIImageView *imageView = [self kk_navbarImageView];
    imageView.alpha = kk_alpha;
}

- (CGFloat)kk_alpha {
    return [self kk_navbarImageView].alpha;
}

// 使导航栏透明，放到 viewWillAppear 中
- (void)kk_transtransparentEnable {
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationBar.shadowImage = [UIImage new];
}

// 恢复导航栏不透明状态，放到 viewWillDisappear 中
- (void)kk_transtransparentDisable {
    //  如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];
}

@end
