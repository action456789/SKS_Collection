//
//  UPEjectShrinkBtnsView.m
//  HQProject
//
//  Created by KeSen on 2016/12/13.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "UPEjectShrinkBtnsView.h"
#import "UIView+Frame.h"

#define kBtnW 30
#define kBtnH 30
#define kBtnsPadding 20
#define kBtnCount 4

@interface UPEjectShrinkBtnsView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;

@end

@implementation UPEjectShrinkBtnsView
{
    CGFloat _originalW;
    CGRect _frame;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        
        _shouldBtnsEject = YES;
        _animatable = YES;
        _isAnimating = NO;
        
        _btnArray = [NSMutableArray array];
        _originalW = frame.size.width;

        if (frame.size.width > kBtnW) {
            self.layer.cornerRadius = frame.size.height * 0.6;
        } else {
            self.layer.cornerRadius = frame.size.height * 0.5;
        }
        
        self.layer.masksToBounds = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self createBtns];
    }
    return self;
}

- (void)createBtns {
    
    for (NSInteger i=0; i<kBtnCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        if (i == 0) {
            [button setBackgroundImage:[UIImage imageNamed:@"Eject展开.png"] forState:UIControlStateNormal];
        } else if (i == 1) {
            [button setBackgroundImage:[UIImage imageNamed:@"Eject股价预测.png"] forState:UIControlStateNormal];
        } else if (i == 2) {
            [button setBackgroundImage:[UIImage imageNamed:@"Eject最优策略.png"] forState:UIControlStateNormal];
        }else if (i == 3) {
            [button setBackgroundImage:[UIImage imageNamed:@"Eject优品测评.png"] forState:UIControlStateNormal];
        }

        CGFloat x = i * (kBtnW + kBtnsPadding);
        button.frame = CGRectMake(x, 0, kBtnW, kBtnH);
        button.centerY = _frame.size.height * 0.5;
        
        [self.btnArray addObject:button];
        
        [self addSubview:button];
    }
    
    [self bringSubviewToFront:self.btnArray[0]];
}

- (void)buttonClicked:(UIButton *)sender {
    
    if (self.isAnimating) {
        return;
    }
    
    if (sender.tag == 0) {
        self.shouldBtnsEject = !self.shouldBtnsEject;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ejectShrinkBtnsView:didClickedButtonAtIndex:)]) {
        [self.delegate ejectShrinkBtnsView:self didClickedButtonAtIndex:sender.tag];
    }
}

- (void)setBtnsAlpha:(CGFloat)alpha {
    for (NSInteger i=1; i<self.btnArray.count; i++) {
        self.btnArray[i].alpha = alpha;
    }
}

- (void)shrinkBtnsWithAnimate:(BOOL)animate {
    
    [self.btnArray[0] setBackgroundImage:[UIImage imageNamed:@"Eject收起.png"] forState:UIControlStateNormal];

    if (animate) {
        self.isAnimating = YES;
        
        if (self.animateOption == EjectShrikAnimationTypeSpring) {
            [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    
                for (NSInteger i=1; i<self.btnArray.count; i++) {
                    self.btnArray[i].x = self.btnArray[0].x - kBtnW - 20;
                }
            } completion:^(BOOL finished) {
    
                self.width = kBtnW;
                self.isAnimating = NO;
            }];
        } else if (self.animateOption == EjectShrikAnimationTypeKeyFrame) {
            CGFloat duration = 0.33;
            CGFloat persent = (self.btnArray.count-1) * 1.0;
            [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
                for (int i=1; i<self.btnArray.count; i++) {
                    [UIView addKeyframeWithRelativeStartTime:(i-1)/persent relativeDuration:1/persent animations:^{
                        self.btnArray[i].x = self.btnArray[0].x - kBtnW - 20;
                    }];
                }
            } completion:^(BOOL finished) {
                self.width = kBtnW;
                self.isAnimating = NO;
            }];
        } else if (self.animateOption == EjectShrikAnimationTypeMengToSpring) {
            
        }
        

        
    } else {
        for (NSInteger i=1; i<self.btnArray.count; i++) {
            self.btnArray[i].x = self.btnArray[0].x - kBtnW - 20;
        }
        self.width = kBtnW;
    }
}

- (void)ejectBtnsWithAnimate:(BOOL)animate {
    
    self.width = _originalW;
    [self.btnArray[0] setBackgroundImage:[UIImage imageNamed:@"Eject展开.png"] forState:UIControlStateNormal];

    if (animate) {
        
        self.isAnimating = YES;
        
        if (self.animateOption == EjectShrikAnimationTypeSpring) {
            [UIView animateWithDuration:0.33 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
                for (NSInteger i=1; i<self.btnArray.count; i++) {
                    self.btnArray[i].x = i * (kBtnW + kBtnsPadding);
                }
    
            } completion:^(BOOL finished) {
                self.isAnimating = NO;
            }];
        } else if (self.animateOption == EjectShrikAnimationTypeKeyFrame) {
            CGFloat duration = 0.2;
            CGFloat persent = (self.btnArray.count-1) * 1.0;
            [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
                for (int i=1; i<self.btnArray.count; i++) {
                    [UIView addKeyframeWithRelativeStartTime:(i-1)/persent relativeDuration:1/persent animations:^{
                        self.btnArray[i].x = i * (kBtnW + kBtnsPadding);
                    }];
                }
            } completion:^(BOOL finished) {
                self.isAnimating = NO;
            }];
        } else if (self.animateOption == EjectShrikAnimationTypeMengToSpring) {
            
        }
        

    } else {
        for (NSInteger i=1; i<self.btnArray.count; i++) {
            self.btnArray[i].x = i * (kBtnW + kBtnsPadding);
        }
    }
}

#pragma mark - getter, setter

- (void)setShouldBtnsEject:(BOOL)shouldBtnsEject {
    _shouldBtnsEject = shouldBtnsEject;
    
    if (_shouldBtnsEject) {
        [self ejectBtnsWithAnimate:self.animatable]; // 弹出
    } else {
        [self shrinkBtnsWithAnimate:self.animatable]; // 收起
    }
}

@end
