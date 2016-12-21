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
        
        CGFloat seperaterWidthsSum = (self.itemTitles.count - 1) * kSTBSperaterWidth;
        CGFloat w = (STB_SCREEN_WIDTH - kSTBFirstItemLeftPadding - kSTBLastItemRightPadding - seperaterWidthsSum) / views.count;
        CGFloat offsetX = (w + kSTBSperaterWidth) * idx ;
        
        UIView *superView = itemButton.superview;
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(superView.mas_top);
            make.height.mas_equalTo(@(kSTBTopViewHeight * kSTBItemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(offsetX);
            make.width.mas_equalTo(@(w));
        }];
        
        itemX += w;
        
        if (self.showSeperater && idx != self.itemTitles.count - 1) {
            UIView *seperaterView = [UIView new];
            seperaterView.backgroundColor = kSTBColorWithHex(kSTBSeperaterColor);
            [superView addSubview:seperaterView];
            
            [seperaterView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(itemButton.mas_right);
                make.width.mas_equalTo(kSTBSperaterWidth);
                make.height.mas_equalTo(kSTBSperaterHeight);
                make.centerY.mas_equalTo(itemButton);
            }];
        }
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    return (STB_SCREEN_WIDTH / self.itemTitles.count) - ((kSTBFirstItemLeftPadding - kSTBItemLineLeftOverWidtht) * 2);
}

- (BOOL)itemScrollViewScrollEnable {
    return NO;
}

- (BOOL)showSeperater {
    return YES;
}

@end
