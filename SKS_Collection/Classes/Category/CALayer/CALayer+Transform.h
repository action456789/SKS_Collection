//
//  CALayer+Transform.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/30.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Transform)

@property (nonatomic) CGFloat kk_transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic) CGFloat kk_transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic) CGFloat kk_transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic) CGFloat kk_transformRotationZ;    ///< key path "tranform.rotation.z"
@property (nonatomic) CGFloat kk_transformScale;        ///< key path "tranform.scale"
@property (nonatomic) CGFloat kk_transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat kk_transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat kk_transformScaleZ;       ///< key path "tranform.scale.z"
@property (nonatomic) CGFloat kk_transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic) CGFloat kk_transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic) CGFloat kk_transformTranslationZ; ///< key path "tranform.translation.z"

/**
 Shortcut for transform.m34, -1/1000 is a good value.
 It should be set before other transform shortcut.
 */
@property (nonatomic) CGFloat kk_transformDepth;

/**
 Wrapper for `contentsGravity` property.
 */
@property (nonatomic) UIViewContentMode kk_contentMode;

@end
