//
//  TipsView.m
//  SKS_Collection
//
//  Created by KeSen on 8/16/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "KKTipsView.h"
#import <Masonry/Masonry.h>
#import "UIView+Frame.h"
#import "KKTipsMaskView.h"

#define kLandscape      UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#define kScreenWidth    (kLandscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   (kLandscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)

/* 结构
TipsView
  _shadowView
  _containertView
 
 */


@interface KKTipsView()

@property (nonatomic, strong) UIWindow *containerView;

@end

@implementation KKTipsView
{
    KKTipsMaskView *_maskView;
    UIView *_containertView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _isShowing = NO;
        _isAnimating = NO;
        
        _showingMask = YES;
        _isMaskUserInteractive = YES;
        
        [self _createSubViews];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isMaskUserInteractive) {
        return [super hitTest:point withEvent:event];
    } else {
        UIView *hitView = [super hitTest:point withEvent:event];
        if(hitView == self) {
            return nil;
        }
        return hitView;
    }
}

- (void)_createSubViews
{
    _maskView = ({
        KKTipsMaskView *view = [[KKTipsMaskView alloc] init];
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
        view.backgroundColor = [UIColor clearColor];
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
    [self hideWithAnimatable:YES];
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
        make.size.mas_equalTo(self->_contentViewSize);
    }];
}

- (void)setShowType:(KKTipsViewShowType)showType
{
    _showType = showType;
    
    if (showType == KKTipsViewShowTypeFromBottom) {
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
            make.edges.mas_equalTo(self->_containertView);
        }];
    } else {
        [_containertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self->_containertView);
        }];
    }
}

# pragma - mark public methods

- (void)showInView:(UIView *)superView animatable:(BOOL)animatable {
    if (_isShowing) {
        [self hideWithAnimatable:NO];
        return;
    }
    
    _isShowing = YES;
    
    UIView *superViewOrKeyWindows = nil;
    if (superView == nil) {
        superViewOrKeyWindows = self.containerView;
    } else {
        superViewOrKeyWindows = superView;
        self.kk_size = CGSizeMake(superView.frame.size.width, superView.frame.size.height);
    }
    
    _maskView.hidden = !self.showingMask;
    
    if (animatable) {
        _isAnimating = YES;
        
        if (self.showType == KKTipsViewShowTypeFromBottom) {
            [superViewOrKeyWindows addSubview:self];
            
            CGFloat offset = 0;
            if ([[UIDevice currentDevice].systemVersion doubleValue] < 8.0) {
                offset = 64 * 4 - 13;
            }
            
            [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:25.f options:UIViewAnimationOptionCurveEaseOut animations:^{
                self->_containertView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewSize.height-offset);
                self->_maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
            } completion:^(BOOL finished) {
                self->_isAnimating = NO;
            }];
            
        } else {
            [UIView transitionWithView:superViewOrKeyWindows duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [superViewOrKeyWindows addSubview:self];
                self->_maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
            } completion:nil];
        }
    } else {
        if (self.showType == KKTipsViewShowTypeFromBottom) {
            [superViewOrKeyWindows addSubview:self];
            _containertView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewSize.height);
            _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        } else {
            [superViewOrKeyWindows addSubview:self];
        }
    }
}

- (void)hideWithAnimatable:(BOOL)animatable {
    _isShowing = NO;
    
    if (animatable) {
        _isAnimating = YES;
        
        if (self.showType == KKTipsViewShowTypeFromBottom) {
            if ([[UIDevice currentDevice].systemVersion doubleValue] < 8.0) {
                [self removeFromSuperview];
                _isAnimating = NO;
            } else {
                [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self->_containertView.transform = CGAffineTransformIdentity;
                    self->_maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                    self->_isAnimating = NO;
                }];
            }
        } else {
            [UIView transitionWithView:self.superview duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self removeFromSuperview];
            } completion:nil];
        }
    } else {
        if (self.showType == KKTipsViewShowTypeFromBottom) {
            _containertView.transform = CGAffineTransformIdentity;
            _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            [self removeFromSuperview];
        } else {
            [self removeFromSuperview];
        }
    }
}

- (UIView *)containerView {
    return [UIApplication sharedApplication].keyWindow;
}

@end
