//
//  LayerAnimationBaseView.h
//  SKS_Collection
//
//  Created by KeSen on 8/25/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseLayerAnimationView : UIView

@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat delay;


- (void)showWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;

- (void)hideWithDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;

- (void)createPath;

@end
