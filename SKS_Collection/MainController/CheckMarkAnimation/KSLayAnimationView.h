//
//  KSLayAnimationView.h
//  CheckMardAnimation
//
//  Created by KeSen on 16/1/27.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KSLayAnimationType) {

    KSLayAnimationTypeCheckMark, // default
    KSLayAnimationTypeCross
    
};

@interface KSLayAnimationView : UIView

+ (instancetype)layAnimationView;

+ (instancetype)layAnimationViewWithFrame:(CGRect)frame;

- (instancetype)initLayAnimationViewWithFrame:(CGRect)frame strockColor:(UIColor *)color duration:(NSTimeInterval)duration lineWidth:(CGFloat)lineWidth;

- (void)showWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay type:(KSLayAnimationType)type;

- (void)hideWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;

@end
