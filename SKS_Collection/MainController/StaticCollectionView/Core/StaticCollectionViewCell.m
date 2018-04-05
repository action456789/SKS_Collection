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
#import "CommonMacro.h"
#import <UIImageView+WebCache.h>
#import "CommonMacro.h"

// 图片占据整个cell的高度
#define kImageHeightRatio (40.0/60.0)

@interface StaticCollectionViewCell()

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

- (void)setDataModal:(StaticCollectionViewCellItem *)dataModal {
    _dataModal = dataModal;
    self.titleLabel.text = self.dataModal.title;
    
    if ([dataModal.imageName hasPrefix:@"http://"] || [dataModal.imageName hasPrefix:@"https://"]) {
        if (self.dataModal.placeHolderImageName) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModal.imageName]
                              placeholderImage:[UIImage imageNamed:self.dataModal.placeHolderImageName]];
        } else {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModal.imageName]];
        }
       
    } else if (!IsValidateString(dataModal.imageName)) {
        self.imageView.image = [UIImage imageNamed:self.dataModal.placeHolderImageName];
    } else {
        self.imageView.image = [UIImage imageNamed:self.dataModal.imageName];
    }
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [_imageView addGestureRecognizer:tap];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kColorWithHex(0x999999);
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTap:)];
        [_titleLabel addGestureRecognizer:tap];
    }
    return _titleLabel;
}


- (void)imageViewTap:(UITapGestureRecognizer *)tap {
    NSLog(@"imageViewTap");
    self.dataModal.clickedHandle(nil, _imageView, nil);
}

- (void)titleLabelTap:(UITapGestureRecognizer *)tap {
    NSLog(@"titleLabelTap");
    self.dataModal.clickedHandle(nil, nil, _titleLabel);
}

@end
