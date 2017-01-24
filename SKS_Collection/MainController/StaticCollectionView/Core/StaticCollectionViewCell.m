//
//  StaticCollectionViewCell.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionViewCell.h"
#import "StaticCollectionViewCellItem.h"
#import "Masonry.h"
#import "StaticCollectionViewCellItem.h"
#import "CommonMacro.h"

// 图片占据整个cell的高度
#define kImageHeightRatio (40.0/60.0)

@interface StaticCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation StaticCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    
    // --- remake/update constraints here
    
    if (!IsValidateString(self.dataModal.title)) { // 只有图片
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    } else { // 有图片和标题
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(self.frame.size.height * kImageHeightRatio);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.imageView.mas_bottom);
        }];
    }
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)setDataModal:(StaticCollectionViewCellItem *)dataModal {
    _dataModal = dataModal;
    self.titleLabel.text = self.dataModal.title;
    self.imageView.image = [UIImage imageNamed:self.dataModal.imageName];
}

- (void)setImageViewContentMode:(UIViewContentMode)imageViewContentMode {
    self.imageView.contentMode = imageViewContentMode;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kColorWithHex(0x999999);
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

@end
