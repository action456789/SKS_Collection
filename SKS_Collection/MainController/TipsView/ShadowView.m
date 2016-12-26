//
//  UPHQShadowView.m
//  HQProject
//
//  Created by KeSen on 2016/12/26.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "ShadowView.h"
#import "Masonry.h"

#define kLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#define kScreenWidth    (kLandscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   (kLandscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)

@implementation ShadowView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapGestureHandle:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)_createSubViews
{
    _containerView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = 2.0;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.size.mas_equalTo(self.contentViewSize);
        }];
        
        view;
    });
}

@end
