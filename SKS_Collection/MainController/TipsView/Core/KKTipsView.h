//
//  TipsView.h
//  SKS_Collection
//
//  Created by KeSen on 8/16/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

// 支持 iOS8 及以上版本

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KKTipsViewShowType) {
    KKTipsViewShowTypeCenter,
    KKTipsViewShowTypeFromBottom,
};

@interface KKTipsView : UIView

@property (nonatomic, assign) KKTipsViewShowType showType;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) CGSize contentViewSize;

// 是否显示遮罩，默认显示
@property (nonatomic, assign) BOOL showingMask;
// 遮罩是否响应事件，默认 YES
@property (nonatomic, assign) BOOL isMaskUserInteractive;

@property (nonatomic, assign, readonly) BOOL isAnimating;
@property (nonatomic, assign, readonly) BOOL isShowing;

- (void)showInView:(UIView *)superView animatable:(BOOL)animatable;
- (void)hideWithAnimatable:(BOOL)animatable;

@end
