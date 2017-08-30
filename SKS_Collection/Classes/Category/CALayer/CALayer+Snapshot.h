//
//  CALayer+Snapshot.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/30.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Snapshot)

/**
 Take snapshot without transform, image's size equals to bounds.
 */
- (nullable UIImage *)kk_snapshotImage;

/**
 Take snapshot without transform, PDF's page size equals to bounds.
 */
- (nullable NSData *)kk_snapshotPDF;
    
@end
