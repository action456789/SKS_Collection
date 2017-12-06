//
//  SlideTabBarDemo.h
//  SKS_Collection
//
//  Created by KeSen on 7/18/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class SlideTabBarItemControllerDelegate;

@protocol SlideTabBarItemControllerDelegate <NSObject>
@optional
- (void)scrollUp;
- (void)scrollDown;

@end


@interface SlideTabBarItemController : BaseViewController
@property (nonatomic, weak) id<SlideTabBarItemControllerDelegate> delegate;
@end
