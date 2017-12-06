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
    
    __block CGFloat itemX = SegmentControl_HeaderFirstItemLeftPadding;
    
    [views enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemButton;
        if ([view isKindOfClass:[UIButton class]]) {
            itemButton = (UIButton *)view;
        } else {
            return ;
        }
        
        [itemButton setTitle:self.itemTitles[idx] forState:UIControlStateNormal];
        itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        itemButton.titleLabel.font = [UIFont systemFontOfSize:SegmentControl_HeaderItemFontSize];
        
        [itemButton setTitleColor:SegmentControl_HeaderItemFontNormalColor forState:UIControlStateNormal];
        [itemButton setTitleColor:SegmentControl_HeaderItemFontSelectedColor forState:UIControlStateSelected];
        
        CGFloat seperaterWidthsSum = (self.itemTitles.count - 1) * SegmentControl_HeaderSperaterWidth;
        CGFloat w = (kScreenWidth - SegmentControl_HeaderFirstItemLeftPadding - SegmentControl_HeaderLastItemRightPadding - seperaterWidthsSum) / views.count;
        CGFloat offsetX = (w + SegmentControl_HeaderSperaterWidth) * idx ;
        
        UIView *superView = itemButton.superview;
        
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(superView.mas_top);
            make.height.mas_equalTo(@(SegmentControl_HeaderViewHeight * SegmentControl_HeaderItemHeightRatio));
            make.left.mas_equalTo(superView.mas_left).offset(offsetX);
            make.width.mas_equalTo(@(w));
        }];
        
        itemX += w;
        
        if (self.showSeperater && idx != self.itemTitles.count - 1) {
            UIView *seperaterView = [UIView new];
            seperaterView.backgroundColor = SegmentControl_HeaderItemSeperaterColor;
            [superView addSubview:seperaterView];
            
            [seperaterView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(itemButton.mas_right);
                make.width.mas_equalTo(SegmentControl_HeaderSperaterWidth);
                make.height.mas_equalTo(SegmentControl_HeaderSperaterHeight);
                make.centerY.mas_equalTo(itemButton);
            }];
        }
    }];
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    return (kScreenWidth / self.itemTitles.count) - ((SegmentControl_HeaderFirstItemLeftPadding - SegmentControl_HeaderItemLineLeftOverWidtht) * 2);
}

- (BOOL)itemScrollViewScrollEnable {
    return NO;
}

- (BOOL)showSeperater {
    return YES;
}

@end
