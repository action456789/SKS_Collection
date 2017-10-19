//
//  ColorSliderDemoVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/10/19.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ColorSliderDemoVC.h"
#import "ColorSlider.h"

@interface ColorSliderDemoVC () <ColorSliderDelegate>
@property (weak, nonatomic) IBOutlet ColorSlider *colorSlider;

@end

@implementation ColorSliderDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorSlider.delegate = self;
}

- (void)didColorChange:(UIColor *)color {
    NSLog(@"%@", color);
}

- (void)didColorTemperatureWithValue:(CGFloat)value {
    NSLog(@"%f", value);
}


@end
