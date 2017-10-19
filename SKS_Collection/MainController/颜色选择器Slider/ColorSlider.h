//
//  ColorSlider.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/7/6.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ColorSliderType) {
    ColorSliderTypeLightRGB, // 灯光RGB
    ColorSliderTypeColorTemperature, // 色温
};

@protocol ColorSliderDelegate<NSObject>

@optional

-(void)didColorChange:(UIColor *)color;

-(void)didColorTemperatureWithValue:(CGFloat)value;

@end

@interface ColorSlider : UIView

@property(nonatomic, weak) id<ColorSliderDelegate> delegate;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, assign) ColorSliderType type;

@property (nonatomic, strong) UISlider *slider;

// 滑到最左边自动变为默认颜色
@property (nonatomic, assign) BOOL isAutoDefaultColor;
@property (nonatomic, strong) UIColor *defaultColor;

@end
