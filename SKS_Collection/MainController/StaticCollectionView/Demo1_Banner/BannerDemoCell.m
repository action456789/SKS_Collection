//
//  BannerViewCell.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/18.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "BannerDemoCell.h"
#import "Masonry.h"
#import "CommonMacro.h"

@implementation BannerDemoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
    }
    
    return self;
}

- (void)updateConstraints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(200));
    }];
    [super updateConstraints];
}

@end
