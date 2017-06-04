//
//  UIView+Screenshot.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/6/4.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "UIView+Screenshot.h"

@implementation UIView (Screenshot)

- (UIImage *)convertViewToImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES]; UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return image;
}

@end
