//
//  UPHQShadowView.h
//  HQProject
//
//  Created by KeSen on 2016/12/26.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShadowViewContainerType) {
    ShadowViewContainerTypeCenter,
    ShadowViewContainerTypeBottom,
};

@interface ShadowView : UIView

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, assign) ShadowViewContainerType type;
@property (nonatomic, assign) CGSize contentViewSize;

@end
