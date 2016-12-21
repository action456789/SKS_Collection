//
//  KKSlideTabBarLayoutAuto.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSlideTabBarLayoutAuto.h"

@implementation KKSlideTabBarLayoutAuto

-(void)layoutItemsViews:(NSArray *)views {
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
        
        CGFloat titleStringW = [self.itemStringWidths[idx] floatValue];
        CGFloat x = itemX + idx * kSTBItemHorizontalSpace;
        
        UIView *superView = itemButton.superview;
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(superView.mas_top);
            make.height.mas_equalTo(@(kSTBTopViewHeight * kSTBItemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(x);
            make.width.mas_equalTo(@(titleStringW));
        }];
        
        itemX += titleStringW;
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    return [self.itemStringWidths[index] floatValue] + kSTBItemLineLeftOverWidtht * 2;
}

- (BOOL)itemScrollViewScrollEnable {
    return YES;
}

- (BOOL)showSeperater {
    return NO;
}

@end
