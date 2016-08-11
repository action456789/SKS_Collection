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
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@end
