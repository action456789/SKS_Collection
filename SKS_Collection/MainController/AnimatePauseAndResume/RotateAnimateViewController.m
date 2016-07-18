//
//  RoundViewDemoVC.m
//  SKS_Collection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RotateAnimateViewController.h"
#import "CALayer+KS_Animate.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface RotateAnimateViewController()
{
    UIImageView *_imageView;
}
@end

@implementation RotateAnimateViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor blueColor];
    
    [self addSubviews];
    
    [self addCABasicAnimation];
}

- (void)addSubviews {
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl"]];
    _imageView.frame = CGRectMake(100, 100, 100, 100);
    _imageView.clipsToBounds = YES;
    _imageView.userInteractionEnabled = YES;
    _imageView.layer.cornerRadius = 50;
    _imageView.layer.borderWidth = 1.0;
    _imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    _imageView.layer.shadowColor = UIColor.blackColor.CGColor;
    _imageView.layer.shadowRadius = 2;
    _imageView.layer.shadowOpacity = 0.6;
    _imageView.layer.shadowOffset = CGSizeMake(0, 1);
    [self.view addSubview:_imageView];
    
    UIButton *resumeAnimateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resumeAnimateBtn setTitle:@"resume" forState:UIControlStateNormal];
    resumeAnimateBtn.frame = CGRectMake(50, kScreenH -50, 100, 40);
    [resumeAnimateBtn addTarget:self action:@selector(resumeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resumeAnimateBtn];
    
    UIButton *pauseAnimateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pauseAnimateBtn setTitle:@"pause" forState:UIControlStateNormal];
    pauseAnimateBtn.frame = CGRectMake(kScreenW - 50 - 100, kScreenH - 50, 100, 40);
    [pauseAnimateBtn addTarget:self action:@selector(pauseBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseAnimateBtn];
}

-(void)playStatuUpdate:(BOOL)playState {
    NSLog(@"%@...", playState ? @"播放": @"暂停了");
}

- (void)addCABasicAnimation {
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.toValue = @(M_PI * 2);
    rotate.duration = 6.0;
    rotate.repeatCount = MAXFLOAT;
    rotate.cumulative = NO;
    [_imageView.layer addAnimation:rotate forKey:nil];
}

- (void)pauseBtnEvent:(UIButton *)sender {
    [_imageView.layer pauseLayer];
}

- (void)resumeBtnEvent:(UIButton *)sender {
    [_imageView.layer resumeLayer];
}

@end


