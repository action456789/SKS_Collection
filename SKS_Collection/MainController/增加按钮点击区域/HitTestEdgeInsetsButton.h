//
//  HitTestEdgeInsetsButton.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/11.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HitTestEdgeInsetsButton : UIButton

// 四周增加同样的点击区域
@property (nonatomic, assign) CGFloat padding;

// 增加 edgeInserts 点击区域
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
