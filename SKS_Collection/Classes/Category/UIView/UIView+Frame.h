//
//  UIView+KS.h
//  iFanPhoto
//
//  Created by kesen on 14/11/27.
//  Copyright (c) 2014年 柯森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
//简化frame的赋值和取值
@property (assign, nonatomic) CGFloat kk_x;
@property (assign, nonatomic) CGFloat kk_y;
@property (assign, nonatomic) CGFloat kk_centerX;
@property (assign, nonatomic) CGFloat kk_centerY;
@property (assign, nonatomic) CGFloat kk_width;
@property (assign, nonatomic) CGFloat kk_height;
@property (assign, nonatomic) CGSize kk_size;
@property (assign, nonatomic) CGPoint kk_origin;

@end
