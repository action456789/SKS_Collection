//
//  TipsView.m
//  SKS_Collection
//
//  Created by KeSen on 8/16/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "TipsView.h"
#import <Masonry.h>

#define kLandscape      UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

#define kScreenWidth    (kLandscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   (kLandscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)

#define kDevice_iPhone4_4s   (kScreenWidth == 320.f && kScreenHeight == 480.f ? YES : NO)

@interface TipsView()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation TipsView
{
    UIView *_shadowView;
    UIView *_containertView;
    CGSize _contentViewSize;
}

- (instancetype)initWithContentViewSize:(CGSize)size {
    if (self = [super init]) {
//        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _isShowing = NO;
        _isAnimating = NO;
        _contentViewSize = size;
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
            make.size.mas_equalTo(_contentViewSize);
        }];
        
        view;
    });
}

- (void)_tapGestureHandle:(UIGestureRecognizer *)tap
{
    [self hideAnimatable:YES];
}

- (void)setShowType:(TipsViewShowType)showType
{
    _showType = showType;
    
    // 修复在 iOS7 iPhone4_4s 设备上显示不全的问题
    CGFloat offset = 0;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 8.0 && kDevice_iPhone4_4s) {
        offset = -64 * 2;
    }
    
    if (showType == TipsViewShowTypeFromBottom) {
        [_containertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_bottom).offset(offset);
            make.size.mas_equalTo(_contentViewSize);
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
        [self hideAnimatable:NO];
    }
    
    _isShowing = YES;
    
    UIView *superViewOrWindow = nil;
    if (superView == nil) {
        superViewOrWindow = self.window;
    } else {
        superViewOrWindow = superView;
    }
    
    if (animatable) {
        _isAnimating = YES;
        
        if (self.showType == TipsViewShowTypeFromBottom) {
            [superViewOrWindow addSubview:self];
            
            [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:25.f options:UIViewAnimationOptionCurveEaseOut animations:^{
                _containertView.transform = CGAffineTransformMakeTranslation(0, -_contentViewSize.height);
                _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
            } completion:^(BOOL finished) {
                _isAnimating = NO;
            }];
            
        } else {
            [UIView transitionWithView:superView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [superViewOrWindow addSubview:self];
            } completion:nil];
        }
    } else {
        if (self.showType == TipsViewShowTypeFromBottom) {
            [superViewOrWindow addSubview:self];
            _containertView.transform = CGAffineTransformMakeTranslation(0, -_contentViewSize.height);
            _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        } else {
            [superViewOrWindow addSubview:self];
        }
    }
}

- (void)showAnimatable:(BOOL)animatable {
    [self showInView:nil animatable:animatable];
}

- (void)hideAnimatable:(BOOL)animatable {
    _isShowing = NO;
    
    if (animatable) {
        _isAnimating = YES;
        
        if (self.showType == TipsViewShowTypeFromBottom) {
            [UIView animateWithDuration:0.3f delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                _containertView.transform = CGAffineTransformIdentity;
                _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
            } completion:^(BOOL finished) {
                [self clear];
                
                _isAnimating = NO;
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
            
            [self clear];
        
        } else {
            [self removeFromSuperview];
        }
    }
}

- (void)clear {
    [self removeFromSuperview];
    [self.window removeFromSuperview];
    self.window = nil;
}

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel = UIWindowLevelAlert;
        _window.backgroundColor = [UIColor clearColor];
        
        [_window makeKeyAndVisible];
        
//        self.touchLayer = [[UIControl alloc] initWithFrame:self.window.bounds];
//        self.touchLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//        [self.window addSubview:self.touchLayer];
//        [self.touchLayer addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
    }
    
    return _window;
}

@end
