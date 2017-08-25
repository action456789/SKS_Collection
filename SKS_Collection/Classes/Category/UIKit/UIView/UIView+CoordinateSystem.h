//
//  UIView+CoordinateSystem.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/25.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CoordinateSystem)

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)kk_convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)kk_convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)kk_convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)kk_convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@end
