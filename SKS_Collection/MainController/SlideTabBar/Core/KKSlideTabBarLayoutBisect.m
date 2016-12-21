//
//  KKSlideTabBarLayoutBisect.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSlideTabBarLayoutBisect.h"

@implementation KKSlideTabBarLayoutBisect

- (void)layoutItemsViews:(NSArray *)views {
//    NSNumber *sum = [self.itemStringWidths valueForKeyPath: @"@sum.self"];
//    CGFloat totalWidth = sum.floatValue + kSTBItemHorizontalSpace * (self.itemStringWidths.count - 1) + kSTBFirstItemLeftPadding + kSTBLastItemRightPadding;
//    if (totalWidth > STB_SCREEN_WIDTH) {
//
//    }
    
    __block CGFloat itemX = kSTBFirstItemLeftPadding;
    
    [views enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton;
        if ([view isKindOfClass:[UIButton class]]) {
            itemButton = (UIButton *)view;
        } else {
            return ;
        }
        
        [itemButton setTitle:self.itemTitles[idx] forState:UIControlStateNormal];
        itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemButton.titleLabel.font = [UIFont systemFontOfSize:kSTBItemFontSize];
        
        [itemButton setTitleColor:kSTBColorWithHex(kSTBItemButtonColor) forState:UIControlStateNormal];
        [itemButton setTitleColor:kSTBColorWithHex(kSTBItemLineBgColor) forState:UIControlStateSelected];
        
        CGFloat w = (STB_SCREEN_WIDTH - kSTBFirstItemLeftPadding - kSTBLastItemRightPadding) / views.count;
        CGFloat offsetX = w * idx;
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(itemButton.superview.mas_top);
            make.height.mas_equalTo(@(kSTBTopViewHeight * kSTBItemHeightRatio));
            make.left.mas_equalTo(itemButton.superview.mas_left).offset(offsetX);
            make.width.mas_equalTo(@(w));
        }];
        
        itemX += w;
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    return (STB_SCREEN_WIDTH / self.itemTitles.count) - ((kSTBFirstItemLeftPadding - kSTBItemLineLeftOverWidtht) * 2);
}

- (BOOL)itemScrollViewScrollEnable {
    return NO;
}

@end
