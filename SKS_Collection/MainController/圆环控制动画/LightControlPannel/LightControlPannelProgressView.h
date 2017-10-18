//
//  CicleProgressView.h
//  SKS_Collection
//
//  Created by KeSen on 8/19/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BaseLayerAnimationView.h"
@class LightControlPannelProgressView;

@protocol LightControlPannelProgressViewDelegate<NSObject>

@optional
// 输出增加/减少后最终结果
- (void)lightControlPannelProgressView:(LightControlPannelProgressView *)pannelView didValueUpdated:(int64_t)newValue;

@end

@interface LightControlPannelProgressView : UIView

// 是否正在增加
@property (nonatomic, assign, readonly) BOOL isIncreasing;

// 是否正在减少
@property (nonatomic, assign, readonly) BOOL isDecreasing;

@property (nonatomic,weak) id<LightControlPannelProgressViewDelegate> delegate;

// 显示某个进度
- (void)showWithProgress:(int64_t)progress;

// 增加 increasedUnit 个单位, increasedUnit 为负数时为减少
- (void)increaseWithUnit:(int64_t)unit;

// 增加
- (void)startIncrease;
- (void)endIncrease;

// 减少
- (void)startDecrease;
- (void)endDecrease;

@end
