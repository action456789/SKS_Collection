//
//  KKSlideTabBarHeaderView.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/20.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSlideTabBarBaseLayout;

@interface KKSlideTabBarHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   itemTitles:(NSMutableArray *)itemTitles
                       layout:(KKSlideTabBarBaseLayout *)layout;

@end
