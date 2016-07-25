//
//  GradientLayerDemoController.m
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "GradientLayerDemoController.h"

@implementation GradientLayerDemoController
{
    CAGradientLayer *_gradientLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 200, 200);
    gradientLayer.position = self.view.center;
    gradientLayer.borderWidth = 1.f;
    [self.view.layer addSublayer:gradientLayer];
    
    // 设置颜色
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                            (__bridge id)[UIColor greenColor].CGColor,
                            (__bridge id)[UIColor blueColor].CGColor];
    
    // 设置颜色渐变方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    // 设置颜色分割点
    gradientLayer.locations  = @[@(0.25), @(0.5), @(0.75)];
    
    
    // 延时3秒钟执行
    [self performSelector:@selector(gradientLayerLocationAnimation)
               withObject:nil
               afterDelay:1.f];
    
    _gradientLayer = gradientLayer;
}

- (void)gradientLayerLocationAnimation {
    // 颜色分割点效果
    _gradientLayer.locations = @[@(0.01), @(0.5), @(0.99)];
}
@end
