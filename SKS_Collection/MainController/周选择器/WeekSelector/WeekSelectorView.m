//
//  WeekSelectorView.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "WeekSelectorView.h"
#import <Masonry/Masonry.h>
#import "CommonMacro.h"
#import "KKWeek.h"
#import "KKDay.h"

@implementation WeekSelectorView {
    KKWeek *_week;
    
    NSMutableArray<UIButton *> *_btnArray;
    
    NSMutableArray<KKDay *> *_selectedDays;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedDays = [NSMutableArray array];
        _week = [KKWeek new];
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _selectedDays = [NSMutableArray array];
        _week = [KKWeek new];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    _btnArray = [NSMutableArray array];
    
    for (int i = 0; i < _week.aWeek.count; i++) {
        NSString *title = [_week.aWeek[i] description];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:kColorWithHex(0x333333) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"weekSelectorBg"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        
        [self addSubview:btn];
        
        [_btnArray addObject:btn];
    }
}

- (void)btnAction:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    
    KKDay *day = _week.aWeek[sender.tag];
    
    if (sender.isSelected) {
        if (![self.selectedDays containsObject:day]) {
            [self.selectedDays addObject:day];
        }
    } else {
        if ([self.selectedDays containsObject:day]) {
            [self.selectedDays removeObject:day];
        }
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(weekSelectorView:didSelectedDays:)]) {
        [self.delegate weekSelectorView:self didSelectedDays:self.selectedDays];
    }
}

- (void)setDefaultSelectedDays:(NSMutableArray<KKDay *> *)defaultSelectedDays {
    _defaultSelectedDays = defaultSelectedDays;
    [_selectedDays addObjectsFromArray:defaultSelectedDays];
    
    for (KKDay *day in defaultSelectedDays) {
        for (UIButton *btn in _btnArray) {
            if ([[btn titleForState:UIControlStateNormal] isEqualToString:day.description]) {
                [btn setSelected:YES];
            }
        }
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    CGFloat itemLength = 0;
    if (kDevice_iPhone4_4s) {
        itemLength = 34;
    } else if (kDevice_iPhone5_5s) {
        itemLength = 38;
    } else {
        itemLength = 42;
    }
    
    // 水平排列，固定宽度，间隔自动计算
    [_btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:itemLength leadSpacing:0 tailSpacing:0];
    
    [_btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(@(itemLength));
    }];
    
    [super updateConstraints];
}

@end
