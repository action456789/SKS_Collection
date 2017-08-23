//
//  ColorSliderViewController.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/7/5.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "ColorSliderViewController.h"
#import "ColorSlider.h"
#import "CommonMacro.h"
#import "NSObject+KVO.h"

@interface ColorSliderViewController ()

@end

@implementation ColorSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ColorSlider *sliderView = [[ColorSlider alloc] initWithFrame:CGRectMake(100, 100, kScreenWidth - 10, 10)];
    [self.view addSubview:sliderView];
    
    
    CGFloat x = 10;
    CGFloat y = 200;
    CGFloat thumbWidht = 100;
    
    CGPoint startPoint = CGPointMake(x, y);
    CGPoint endPoint = CGPointMake(x + thumbWidht, y);
    
    UIBezierPath *path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(x, y)];
    [path addCurveToPoint:endPoint controlPoint1:CGPointMake(x + 20, y - 100) controlPoint2: CGPointMake(endPoint.x - 20, y - 100)];
    [path closePath];
    path.lineWidth = 1;
    [[UIColor blackColor] setFill];
    [path fill];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.fillColor = nil; // 默认为blackColor
    pathLayer.path = path.CGPath;
    [self.view.layer addSublayer:pathLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)funcA:(NSString *)B {
    NSLog(@"funcA, %@", B);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
