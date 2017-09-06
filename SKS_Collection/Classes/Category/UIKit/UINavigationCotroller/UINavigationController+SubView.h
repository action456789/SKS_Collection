//
//  UINavigationController+SubView.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/9/6.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SubView)

// 导航栏的alpha值
@property (nonatomic, assign) CGFloat kk_alpha;

// 获取导航栏底部的横线
- (UIImageView *)kk_lineView;

// 导航栏背景图片
- (UIImageView *)kk_navbarImageView;

- (void)kk_transtransparentEnable;

- (void)kk_transtransparentDisable;

@end
