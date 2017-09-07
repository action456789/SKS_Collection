//
//  CAGradientLayer+Creator.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/9/7.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAGradientLayer (Creator)

+ (CAGradientLayer *)kk_layerWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

@end
