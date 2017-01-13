//
//  StaticCollectionViewCell.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionViewCell.h"
#import "StaticCollectionViewCellItem.h"
#import <Masonry.h>
#import "StaticCollectionViewCellItem.h"

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
        [self createSubview];
    }
    
    return self;
}

- (void)setData:(StaticCollectionViewCellItem *)item {
    
    self.imageView.image = [UIImage imageNamed:item.imageName];
    self.titleLabel.text = item.title;
}

- (void)createSubview {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(self.frame.size.height * kImageHeightRatio);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
    }];
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end
