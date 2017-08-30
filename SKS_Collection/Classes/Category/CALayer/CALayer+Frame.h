//
//  CALayer+Frame.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/30.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Frame)

@property (nonatomic) CGFloat kk_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat kk_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat kk_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat kk_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat kk_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat kk_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint kk_center;      ///< Shortcut for center.
@property (nonatomic) CGFloat kk_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat kk_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint kk_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  kk_frameSize; ///< Shortcut for frame.size.

@end
