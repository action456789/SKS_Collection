//
//  UPEjectShrinkBtnsView.h
//  HQProject
//
//  Created by KeSen on 2016/12/13.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EjectShrikAnimationType) {
    EjectShrikAnimationTypeSpring,
    EjectShrikAnimationTypeKeyFrame,
};

@class UPEjectShrinkBtnsView;

@protocol UPEjectShrinkBtnsViewDelegate <NSObject>

- (void)ejectShrinkBtnsView:(UPEjectShrinkBtnsView *)view didClickedButtonAtIndex:(NSInteger)index;

@end

@interface UPEjectShrinkBtnsView : UIView

// 是否允许动画
@property (nonatomic, assign) BOOL animatable;

// 设置是否弹出按钮, YES 弹出，NO 缩回
@property (nonatomic, assign) BOOL shouldBtnsEject;

@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, assign) EjectShrikAnimationType animateOption;

@property (nonatomic, weak) id <UPEjectShrinkBtnsViewDelegate> delegate;

@end
