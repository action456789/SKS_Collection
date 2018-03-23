//
//  WeekSelectorView.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/6.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDay.h"
@class WeekSelectorView;

NS_ASSUME_NONNULL_BEGIN

@protocol WeekSelectorViewDelegate <NSObject>

@optional
- (void)weekSelectorView:(WeekSelectorView *)view didSelectedDays:(NSArray<KKDay *> *)days;

@end

@interface WeekSelectorView : UIView

// 选中的天
@property (nonatomic, strong, readonly) NSMutableArray<KKDay *> *selectedDays;

// 默认选中的天
@property (nonatomic, strong) NSMutableArray<KKDay *> *defaultSelectedDays;

@property (nonatomic,weak) id <WeekSelectorViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
