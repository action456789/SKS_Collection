//
//  RiciColorPaletteVC.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/14.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "RiciColorPaletteVC.h"
#import "LightingPaletteComponent.h"
#import "CommonMacro.h"
#import "UIView+Frame.h"
#import "UIView+Color.h"

#define kColorIndicateW 45
#define kShowViewW 100

@interface RiciColorPaletteVC ()

@property (nonatomic, strong) LightingPaletteComponent *colorPalette;
@property (strong, nonatomic) UIImageView *colorWheelView;
@property (strong, nonatomic) UIImageView *colorIndicatorView;
@property (nonatomic, assign) BOOL isColorWheelTouched;

@property (nonatomic, strong) UIView *showingView;

@end

@implementation RiciColorPaletteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多色彩";

    _colorPalette = [[LightingPaletteComponent alloc] init];
    [self createColorWheelView];
    _isColorWheelTouched = false;
    
    [self createShowingView];
}

- (UIColor *)currentColor {
    return [_colorPalette.colorConvert convertToUIColor:_colorPalette.currentColor];
}

- (void)done {
    if ([self.delegate respondsToSelector:@selector(colorPalette:currentColor:)]) {
        [self.delegate colorPalette:self currentColor:[self currentColor]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 创建顶部的展示当前颜色的View
- (void)createShowingView {
    _showingView = [UIImageView new];
    _showingView.frame = CGRectMake(0, 160, kShowViewW, kShowViewW);
    _showingView.kk_centerX = self.view.kk_centerX;
    _showingView.layer.cornerRadius = 50;
    _showingView.backgroundColor = [self currentColor];
    
    [self.view addSubview:_showingView];
}

-(void)createColorWheelView {
    CGFloat startPointX = 30;
    CGFloat viewWidth = kScreenWidth - 60;
    CGFloat startPointY = kScreenHeight - viewWidth - 30;
    CGRect imageFrame = CGRectMake(startPointX, startPointY, viewWidth, viewWidth);
    
    UIImage *weelImage = [_colorPalette createColorWheelImageWithFrame:imageFrame];
    _colorWheelView = [[UIImageView alloc] initWithImage:weelImage];
    _colorWheelView.frame = imageFrame;
    _colorWheelView.layer.masksToBounds = YES;
    _colorWheelView.layer.cornerRadius = viewWidth / 2.0;
    
    [self.view addSubview:_colorWheelView];
    [self createColorIndicateImageAtX:_colorWheelView.kk_centerX atY:_colorWheelView.kk_centerY];
}

/**
// 创建随手指移动的指示器
 */
-(void)createColorIndicateImageAtX:(float)centerPointX atY:(float)centerPointY {
    CGFloat viewWidth = kColorIndicateW;
    CGFloat startPointX = centerPointX - (viewWidth / 2);
    CGFloat startPointY = centerPointY - (viewWidth / 2);
    CGRect imageFrame = CGRectMake(startPointX, startPointY, viewWidth, viewWidth);
    
    UIImage *image = [_colorPalette createColorIndicateImageWithFrame:imageFrame];

    _colorIndicatorView = [[UIImageView alloc] initWithImage:image];
    _colorIndicatorView.frame = imageFrame;
    
    UIColor *color = [self currentColor];
    _showingView.backgroundColor = color;
    
    // 执行代理
    if ([self.delegate respondsToSelector:@selector(colorPalette:currentColor:)]) {
        [self.delegate colorPalette:self currentColor:color];
    }
    
    [self.view addSubview:_colorIndicatorView];
}


/**
 *  NAME
 *      updateIndicatorViewAtX:(CGFloat)x atY:(float)y
 *
 *  DESCRIPTION
 *      Re-create indicator view by point x, y.
 *
 */
-(void)updateIndicatorViewAtX:(CGFloat)x atY:(float)y {
    [_colorIndicatorView removeFromSuperview];
    [self createColorIndicateImageAtX:x atY:y];
}

/**
 *  NAME
 *      isValidPointAtX:(float)x atY:(float)y
 *
 *  DESCRIPTION
 *      This function only action when color wheel is circle.
 *
 */
-(BOOL)isValidPointByRadius:(CGFloat)radius atX:(CGFloat)x atY:(CGFloat)y {
    CGFloat pointX = x - radius;
    CGFloat pointY = radius - y;
    CGFloat r_distance = sqrtf(pow(pointX, 2) + pow(pointY, 2));
    
    if (fabs(r_distance) > radius) {
        return FALSE;
    }
    
    return TRUE;
}

/**
 *  更新颜色指示器的颜色和位置
 */
-(void)updateViewWithTouchEventInTouch:(UITouch *)userTouch {
    CGPoint touchPoint = [userTouch locationInView:self.view];
    CGFloat touchDistance = sqrt(pow((touchPoint.x - _colorWheelView.kk_centerX), 2) +
                                 pow((touchPoint.y - _colorWheelView.kk_centerY), 2));
    CGFloat radius = _colorWheelView.frame.size.width / 2;
    
    if (_isColorWheelTouched == TRUE) {
        CGPoint point = [userTouch locationInView:_colorWheelView];
        
        [_colorPalette getColorWheelBitmapDataByRadius:radius atX:point.x atY:point.y];
        
        if (touchDistance > radius) {
            CGFloat n = radius / (touchDistance - radius);
            CGFloat distanceX = (_colorWheelView.kk_centerX + (touchPoint.x * n)) / (1 + n);
            CGFloat distanceY = (_colorWheelView.kk_centerY + (touchPoint.y * n)) / (1 + n);
            [self updateIndicatorViewAtX:distanceX atY:distanceY];
        } else {
            [self updateIndicatorViewAtX:touchPoint.x atY:touchPoint.y];
        }
        
    }
}

/**
 *  NAME
 *      touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 *
 *  DESCRIPTION
 *      User began touch device panel, update brightness image view and indicator image view.
 *
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    if (touchPoint.x > _colorWheelView.frame.origin.x &&
        touchPoint.x <= (_colorWheelView.frame.origin.x + _colorWheelView.frame.size.width) &&
        touchPoint.y > _colorWheelView.frame.origin.y &&
        touchPoint.y <= (_colorWheelView.frame.origin.y + _colorWheelView.frame.size.height)) {
        CGPoint colorWheelPoint = [touch locationInView:_colorWheelView];
        CGFloat radius = _colorWheelView.frame.size.width / 2;
        
        if ([self isValidPointByRadius:radius
                                   atX:colorWheelPoint.x
                                   atY:colorWheelPoint.y]) {
            [_colorPalette getColorWheelBitmapDataByRadius:radius
                                                      atX:colorWheelPoint.x
                                                      atY:colorWheelPoint.y];
            [self updateIndicatorViewAtX:touchPoint.x atY:touchPoint.y];
            _isColorWheelTouched = true ;
        }
    }
}

/**
 *  NAME
 *      touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
 *
 *  DESCRIPTION
 *      During user touch device panel, update brightness image view and indicator image view.
 *
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self updateViewWithTouchEventInTouch:touch];
}

/**
 *  NAME
 *      touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 *
 *  DESCRIPTION
 *      After user touch device panel, update brightness image view and indicator image view.
 *
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self updateViewWithTouchEventInTouch:touch];
    _isColorWheelTouched = false;
}

/**
 *  NAME
 *      shouldAutorotate
 *
 *  DESCRIPTION
 *      Do not rotate.
 *
 */
-(BOOL)shouldAutorotate {
    return NO;
}

@end
