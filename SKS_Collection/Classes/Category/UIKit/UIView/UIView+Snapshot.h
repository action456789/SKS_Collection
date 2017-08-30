//
//  UIView+Snapshot.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/30.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Snapshot)

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)kk_snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)kk_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)kk_snapshotPDF;

@end
