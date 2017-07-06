//
//  ColorSlider.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/7/6.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ColorSlider.h"
#import "CommonMacro.h"
#import "Masonry.h"
#import "UIView+Color.h"

@interface ColorSlider()

@end

@implementation ColorSlider {
    UISlider *_slider;
    
    UIColor *_selectColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    
    _slider.minimumValue = 0.01;
    _slider.maximumValue = 0.99;
    _slider.value = 0.01;
    
    [_slider addTarget:self action:@selector(sliderdidEndclick:) forControlEvents:UIControlEventTouchUpInside];
    //滑块拖动时的事件
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_slider];
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
    
    [self setThumb];
    
    [super updateConstraints];
}

- (void)setThumb {
    UIColor *color = [self colorOfPoint:CGPointMake(1, self.frame.size.height - 1)];
    
    UIImage *image = [self getThumbImageWithColor:color];
    
    [_slider setThumbImage:image forState:UIControlStateNormal];
    [_slider setThumbImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)getThumbImageWithColor: (UIColor *)color {
    CGSize size = CGSizeMake(30, 15);
    UIGraphicsBeginImageContext(size);
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

-(void)sliderValueChanged:(UISlider*)slider {
    CGPoint point = CGPointMake(_slider.frame.size.width * slider.value, self.frame.size.height - 1);
    UIColor *color = [self colorOfPoint:point];
    
    _selectColor = color;
    
    UIImage *image = [self getThumbImageWithColor:color];
    
    [slider setThumbImage:image forState:UIControlStateNormal];
    [slider setThumbImage:image forState:UIControlStateHighlighted];
}

-(void)sliderdidEndclick:(UISlider *)slider {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didColorChange:)]) {
        [self.delegate didColorChange:_selectColor];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didColorChange:withValue:)]) {
        [self.delegate didColorChange:_selectColor withValue:slider.value];
    }
}

@end
