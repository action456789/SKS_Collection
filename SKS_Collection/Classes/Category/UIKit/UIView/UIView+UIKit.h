//
//  UIView+Convenient.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIKit)

// 给 UIView 添加一个 Button 用于响应高亮事件
- (UIButton *)addButtonOnTopWithHighLightColor: (UIColor *)color;

// 递归查找高度或宽度 <=1 的View
+ (UIImageView *)kk_findLineView:(UIView*)view;

@end
