//
//  KSNumberIncreaseAnimationView.h
//  CheckMardAnimation
//
//  Created by KeSen on 16/1/29.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSNumberIncreaseAnimationView : UIView

- (instancetype)initWithFrame:(CGRect)frame number:(CGFloat)number;

- (void)showFromNumber:(CGFloat)from toNumber:(CGFloat)to WithDuration:(CGFloat)duration delay:(CGFloat)delay;

- (void)hide;

@end
