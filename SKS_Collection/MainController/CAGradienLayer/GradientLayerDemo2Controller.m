//
//  GradientLayerDemo2Controller.m
//  SKS_Collection
//
//  Created by KeSen on 7/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "GradientLayerDemo2Controller.h"

@implementation GradientLayerDemo2Controller
{
    CAGradientLayer *_gradientLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"girl"].CGImage);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor,
                            (id)[[UIColor redColor] colorWithAlphaComponent:1.0f].CGColor];
    gradientLayer.locations = @[[NSNumber numberWithFloat:0.7f],
                                [NSNumber numberWithFloat:1.0f]];

    [self.view.layer addSublayer:gradientLayer];
    
    _gradientLayer = gradientLayer;
    
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
}

- (void)timerEvent
{
    _gradientLayer.locations = @[[NSNumber numberWithFloat:arc4random()%100/100.f],
                                 [NSNumber numberWithFloat:1.0f]];
    
    _gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor,
                              (id)[[UIColor colorWithRed:arc4random()%255/255.f
                                                       green:arc4random()%255/255.f
                                                        blue:arc4random()%255/255.f
                                                       alpha:1.0] colorWithAlphaComponent:1.0f].CGColor];
}


@end
