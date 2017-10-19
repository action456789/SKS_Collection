//
//  HomeDeviceInfoCell.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/16.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import "StaticCollectionViewDemo2Cell.h"
#import "Masonry.h"
#import "CommonMacro.h"
#import "UIView+CornerRadio.h"

@implementation StaticCollectionViewDemo2Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = kColorWithHex(0x129EC5);
    }
    
    return self;
}

- (void)updateConstraints {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(55);
        make.top.mas_equalTo(self).offset(12);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-8);
    }];
    
    [super updateConstraints];
}

@end
