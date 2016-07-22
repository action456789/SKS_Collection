//
//  CALayer+KSKit.h
//  KsCollection
//
//  Created by KeSen on 15/12/11.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (KS_Animate)
/**
 *  暂停动画
 */
-(void)pauseLayer;
/**
 *  继续动画
 */
-(void)resumeLayer;

@end
