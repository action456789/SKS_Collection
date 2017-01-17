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

// 图片占据整个cell的高度
#define kImageHeightRatio (40.0/60.0)

@interface StaticCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isFirstSettingModal;

@end

@implementation StaticCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
        self.isFirstSettingModal = YES;
    }
    
    return self;
}

- (void)setDataModal:(StaticCollectionViewCellItem *)dataModal {
    _dataModal = dataModal;
 
    if (_dataModal.title == nil) {
        _dataModal.title = @"";
    }
    
    if (_dataModal.imageName == nil) {
        _dataModal.imageName = @"";
    }
    
    if (self.isFirstSettingModal) {
        [self addKVO];
    }
    self.isFirstSettingModal = NO;
}

- (void)addKVO {
    [self.dataModal addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial  context:nil];
    [self.dataModal addObserver:self forKeyPath:@"imageName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial  context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.titleLabel.text = self.dataModal.title;
    } else if ([keyPath isEqualToString:@"imageName"]) {
        self.imageView.image = [UIImage imageNamed:self.dataModal.imageName];
    }
}

- (void)dealloc {
    [self.dataModal removeObserver:self forKeyPath:@"title"];
    [self.dataModal removeObserver:self forKeyPath:@"imageName"];
}

- (void)createSubview {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
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
