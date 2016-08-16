//
//  TipsView.m
//  SKS_Collection
//
//  Created by KeSen on 8/16/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "TipsView.h"
#import "UIDevice+KS.h"
#import <Masonry.h>

@implementation TipsView
{
    UIView *_shadowView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self _createContentView];
    }
    return self;
}

- (void)_createContentView
{
    _shadowView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapGestureHandle:)];
        [view addGestureRecognizer:tap];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        view;
    });
    
    _contentView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = 2.0;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(self.contentViewSize);
        }];
        
        view;
    });
}

- (void)_tapGestureHandle:(UIGestureRecognizer *)tap
{
    [self hide];
}

#pragma mark - getter, setter

- (CGSize)contentViewSize
{
    CGSize size = CGSizeZero;
    if (_contentViewSize.height <= 0 || _contentViewSize.width <= 0) {
        size = CGSizeMake(ScreenWidth * 0.8, ScreenWidth * 0.8 * 0.7);
    } else {
        size = self.contentViewSize;
    }
    return size;
}

- (void)setShowType:(TipsViewShowType)showType
{
    _showType = showType;
    
    if (showType == TipsViewShowTypeFromBottom) {
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(self.contentViewSize.height);
        }];
    }
}

- (void)showWithView:(UIView *)superView
{
    if (self.showType == TipsViewShowTypeFromBottom) {
        [superView addSubview:self];
        
        [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:0.99f initialSpringVelocity:45.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewSize.height);
            _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        } completion:nil];
        
    } else {
        [UIView transitionWithView:superView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [superView addSubview:self];
        } completion:nil];
    }
}

- (void)hide
{
    if (self.showType == TipsViewShowTypeFromBottom) {
        [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:0.8f initialSpringVelocity:25.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _contentView.transform = CGAffineTransformIdentity;
            _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [UIView transitionWithView:self.superview duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self removeFromSuperview];
            self.hidden = YES;
        } completion:nil];
    }
}

@end
