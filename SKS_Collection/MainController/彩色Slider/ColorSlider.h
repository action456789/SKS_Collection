//
//  ColorSlider.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/7/6.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorSliderDelegate<NSObject>

@optional
-(void)didColorChange:(UIColor *)color;//颜色回调
-(void)didColorChange:(UIColor *)color withValue:(CGFloat)value;//颜色与slider值回调

@end

@interface ColorSlider : UIView

@property(nonatomic, weak) id<ColorSliderDelegate> delegate;
@property (nonatomic, strong) UIImageView *bgImageView;

@end
