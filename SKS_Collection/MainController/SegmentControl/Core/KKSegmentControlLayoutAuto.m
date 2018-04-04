//
//  KKSlideTabBarLayoutAuto.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSegmentControlLayoutAuto.h"

@implementation KKSegmentControlLayoutAuto

-(void)layoutItemsViews:(NSArray *)views {
    __block CGFloat itemX = self.config.firstItemLeftPadding;
    
    [views enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton;
        if ([view isKindOfClass:[UIButton class]]) {
            itemButton = (UIButton *)view;
        } else {
            return ;
        }
        [itemButton setTitle:self.itemTitles[idx] forState:UIControlStateNormal];
        itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemButton.titleLabel.font = [UIFont systemFontOfSize:self.config.itemFontSize];
        
        [itemButton setTitleColor:self.config.itemFontNormalColor forState:UIControlStateNormal];
        [itemButton setTitleColor:self.config.itemFontSelectedColor forState:UIControlStateSelected];
        
        CGFloat titleStringW = [self.itemStringWidths[idx] floatValue];
        CGFloat x = itemX + idx * self.config.itemHorizontalSpace;
        
        UIView *superView = itemButton.superview;
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(superView.mas_top);
            make.height.mas_equalTo(@(self.config.headerViewHeight * self.config.itemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(x);
            make.width.mas_equalTo(@(titleStringW));
        }];
        
        itemX += titleStringW;
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    if (self.itemStringWidths.count > 0) {
        return [self.itemStringWidths[index] floatValue] + self.config.slideLeftRightOverWidth * 2;
    }
    return 0;
}

- (BOOL)itemScrollViewScrollEnable {
    return YES;
}

- (BOOL)showSeperater {
    return NO;
}

@end
