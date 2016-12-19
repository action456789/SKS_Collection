//
//  TipsView.m
//  SKS_Collection
//
//  Created by KeSen on 8/16/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "TipsView.h"
#import <Masonry.h>

#define kLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#define kScreenWidth    (kLandscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   (kLandscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)

@interface TipsView()

@end

@implementation TipsView
{
    UIView *_shadowView;
    BOOL _isShowing;
    UIView *_containertView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _isShowing = NO;
        [self _createSubViews];
    }
    return self;
}

- (void)_createSubViews
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
    
    _containertView = ({
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
        size = CGSizeMake(kScreenWidth * 0.8, kScreenWidth * 0.8 * 0.7);
    } else {
        size = _contentViewSize;
    }
    return size;
}

@synthesize contentViewSize = _contentViewSize;
- (void)setContentViewSize:(CGSize)contentViewSize {
    _contentViewSize = contentViewSize;
    
    [_containertView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_contentViewSize);
    }];
}

- (void)setShowType:(TipsViewShowType)showType
{
    _showType = showType;
    
    if (showType == TipsViewShowTypeFromBottom) {
        [_containertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(self.contentViewSize.height);
        }];
    }
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    
    if (![_containertView.subviews containsObject:_contentView]) {
        [_containertView addSubview:_contentView];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_containertView);
        }];
    } else {
        [_containertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_containertView);
        }];
    }
}

# pragma - mark public methods

- (void)showInView:(UIView *)superView animatable:(BOOL)animatable {
    if (_isShowing) {
        [self hideWithAnimatable:NO];
    }
    
    if (animatable) {
        _isShowing = YES;
        
        if (self.showType == TipsViewShowTypeFromBottom) {
            [superView addSubview:self];
            
            [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:25.f options:UIViewAnimationOptionCurveEaseOut animations:^{
                _containertView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewSize.height);
                _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            } completion:nil];
            
        } else {
            [UIView transitionWithView:superView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [superView addSubview:self];
            } completion:nil];
        }
    } else {
        if (self.showType == TipsViewShowTypeFromBottom) {
            [superView addSubview:self];
            _containertView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewSize.height);
            _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        } else {
            [superView addSubview:self];
        }
    }
}

- (void)hideWithAnimatable:(BOOL)animatable {
    if (animatable) {
        _isShowing = NO;
        
        if (self.showType == TipsViewShowTypeFromBottom) {
            [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                _containertView.transform = CGAffineTransformIdentity;
                _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        } else {
            [UIView transitionWithView:self.superview duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self removeFromSuperview];
            } completion:nil];
        }
    } else {
        if (self.showType == TipsViewShowTypeFromBottom) {
            _containertView.transform = CGAffineTransformIdentity;
            _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            [self removeFromSuperview];
        } else {
            [self removeFromSuperview];
        }
    }
}

@end
