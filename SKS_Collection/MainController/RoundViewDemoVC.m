//
//  RoundViewDemoVC.m
//  SKS_Collection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RoundViewDemoVC.h"
#import "JingRoundView.h"
#import "CALayer+KS_Animate.h"

@interface RoundViewDemoVC()<JingRoundViewDelegate>

@property (strong, nonatomic) JingRoundView *roundView;

@property (strong, nonatomic) UIImageView *imageView;


@end

@implementation RoundViewDemoVC

- (void)viewDidLoad
{
    [self addCABasicAnimation];
}

-(void)playStatuUpdate:(BOOL)playState {
    NSLog(@"%@...", playState ? @"播放": @"暂停了");
}

- (void)jingRoundViewDemo {
    self.roundView = [[JingRoundView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.roundView.delegate = self;
    self.roundView.roundImage = [UIImage imageNamed:@"girl"];
    self.roundView.rotationDuration = 8.0;
    self.roundView.isPlay = NO;
    [self.view addSubview:self.roundView];
}

- (void)addCABasicAnimation {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl"]];
    imageView.bounds = CGRectMake(0, 0, 100, 100);
    imageView.center = self.view.center;
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.toValue = @(M_PI * 2);
    rotate.duration = 6.0;
    rotate.repeatCount = MAXFLOAT;
    rotate.cumulative = NO;
    [imageView.layer addAnimation:rotate forKey:nil];
}

- (IBAction)status1BtnEvent:(UIButton *)sender {
    [self.imageView.layer pauseLayer];
}

- (IBAction)status2BtnEvent:(UIButton *)sender {
    [self.imageView.layer resumeLayer];
}

@end


