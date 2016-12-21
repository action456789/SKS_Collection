//
//  TipsView.h
//  SKS_Collection
//
//  Created by KeSen on 8/16/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TipsViewShowType) {
    TipsViewShowTypeCenter,
    TipsViewShowTypeFromBottom,
};

@interface TipsView : UIView

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, assign) CGSize contentViewSize;
@property (nonatomic, assign) TipsViewShowType showType;

- (void)showWithView:(UIView *)superView;
- (void)hide;

@end
