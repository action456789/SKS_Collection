//
//  ColorSlider.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/7/6.
//  Copyright © 2017年 SenKe. All rights reserved.
//  TODO: Fix Bug

#import "ColorSlider.h"
#import "CommonMacro.h"
#import <Masonry.h>
#import "UIView+Color.h"

#define kMinColorTempteraturaValue   3000
#define kMaxColorTempteraturaValue   12000

@interface ColorSlider()

@end

// TODO: Fix Bug

@implementation ColorSlider {    
    UIColor *_selectColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_RGB"]];
    [self addSubview:_bgImageView];
    
    _slider = [[UISlider alloc] init];
    
    _slider.backgroundColor = [UIColor clearColor];
    _slider.minimumTrackTintColor = [UIColor clearColor];
    _slider.maximumTrackTintColor = [UIColor clearColor];
    
    _slider.minimumValue = 0.00;
    _slider.maximumValue = 0.95;
    _slider.value = 0.00;
    
    [_slider addTarget:self action:@selector(sliderdidEndclick:) forControlEvents:UIControlEventTouchUpInside];
    //滑块拖动时的事件
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_slider];
}

- (void)setType:(ColorSliderType)type {
    _type = type;
    if (_type == ColorSliderTypeLightRGB) {
        _bgImageView.image = [UIImage imageNamed:@"light_RGB"];
    } else {
        _bgImageView.image = [UIImage imageNamed:@"light_ln"];
    }
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@4);
        make.left.right.bottom.equalTo(self);
    }];
    
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
    
    [self sliderValueChanged:nil];
}

- (UIImage *)getThumbImageWithColor: (UIColor *)color {
    CGSize size = CGSizeMake(30, 15);
    // 0.0的意思就是自动调整缩放因子以适配显示屏
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    UIBezierPath *bezier3Path = UIBezierPath.bezierPath;
    [bezier3Path moveToPoint: CGPointMake(0.5, 8.5)];
    [bezier3Path addCurveToPoint: CGPointMake(9.06, 3.65) controlPoint1: CGPointMake(0.5, 8.5) controlPoint2: CGPointMake(4.84, 8.09)];
    [bezier3Path addCurveToPoint: CGPointMake(22.31, 3.68) controlPoint1: CGPointMake(13.28, -0.78) controlPoint2: CGPointMake(18.18, -0.49)];
    [bezier3Path addCurveToPoint: CGPointMake(30.5, 8.5) controlPoint1: CGPointMake(26.44, 7.85) controlPoint2: CGPointMake(30.5, 8.5)];
    [bezier3Path addLineToPoint: CGPointMake(0.5, 8.5)];
    
    [bezier3Path closePath];
    bezier3Path.lineWidth = 1;
    [color setFill];
    [bezier3Path fill];
    
    //从Context中获取图像，并显示在界面上
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)sliderValueChanged:(UISlider *)slider {
    CGPoint point = CGPointMake(_slider.frame.size.width * _slider.value, self.frame.size.height - 1);
    UIColor *color = [self kk_colorOfPoint:point];
    
    _selectColor = color;
    
    UIImage *image = [self getThumbImageWithColor:color];
    
//    NSLog(@"%f", slider.value);
    if (self.isAutoDefaultColor == YES && slider.value <= 0.01) {
        image = [self getThumbImageWithColor:self.defaultColor];
    }
    
    [_slider setThumbImage:image forState:UIControlStateNormal];
    [_slider setThumbImage:image forState:UIControlStateHighlighted];
}

-(void)sliderdidEndclick:(UISlider *)slider {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didColorChange:)]) {
        [self.delegate didColorChange:_selectColor];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didColorTemperatureWithValue:)]) {
        [self.delegate didColorTemperatureWithValue:[self colorTemperatureWithSlideValue:_slider.value]];
    }
}

- (CGFloat)colorTemperatureWithSlideValue:(CGFloat)value {
    CGFloat max = kMaxColorTempteraturaValue;
    CGFloat min = kMinColorTempteraturaValue;
    
    CGFloat range = max - min;
    CGFloat persent = _slider.value / (_slider.maximumValue - _slider.minimumValue);
    if (persent > 1.0) {
        persent = 1.0;
    }
    CGFloat result = min + range * persent;

    return (NSInteger)result;
}

- (UIColor *)defaultColor {
    return _defaultColor == nil ? [UIColor grayColor] : _defaultColor;
}

@end
