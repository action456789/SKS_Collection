//
//  UITableViewCell+ImageView.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/23.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "UITableViewCell+ImageView.h"

@implementation UITableViewCell (ImageView)

- (void)kk_setImageViewWidth:(CGFloat)widht height:(CGFloat)height {
    CGSize size = CGSizeMake(widht, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, widht, height);
    [self.imageView.image drawInRect:imageRect];
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
