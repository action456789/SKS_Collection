//
//  StaticCell.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "KKStaticCell.h"
#import "KKStaticCellItem.h"
#import "CommonMacro.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface KKStaticCell()

@property (nonatomic, strong) UISwitch *rightContentSwitchView;

@property (nonatomic, strong) UIView *divider;

@property (nonatomic, strong) UIImageView *rightContentImageView;

@end

// 这里最好用懒加载，因为所有控件只在特定的 cell 类型下才会使用

@implementation KKStaticCell
{
    UIView *_selectedBgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.divider];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    // 当为customerView时，如果customerView使用了Autolayout，cell内部也要使用Autolayout布局，否则会出现customerView的位置错乱
    if (self.item.customerView) {
        [self.item.customerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    
    if (self.item.rightContentImage) {
        [self.rightContentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.contentView.mas_height).multipliedBy(0.8);
            make.height.equalTo(self.contentView.mas_height).multipliedBy(0.8);
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(staticCellSetupAppearance:)]) {
        [self.delegate staticCellSetupAppearance:self];
    } else {
        // 默认设置
        [self setCellAppearance];
    }
    
    [super updateConstraints];
}

- (void)setCellAppearance {
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    [self.textLabel setTextColor: kColorWithHex(0x333333)];
    
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    [self.detailTextLabel setTextColor: kColorWithHex(0x666666)];
}

- (void)setItem:(KKStaticCellItem *)item {
    _item = item;
    
    [self _setupData];
    [self _setupType];
}

- (void)_setupData {
    if (_item.icon) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        if ([self.item.icon hasPrefix:@"http://"] || [self.item.icon hasPrefix:@"https://"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.item.icon] placeholderImage:[UIImage imageNamed:self.item.iconPlaceHolder]];
        } else {
            self.imageView.image = [UIImage imageNamed:self.item.icon];
        }
    }
    
    if (_item.title) {
        self.textLabel.text = self.item.title;
    }
    
    if (_item.detail) {
        self.detailTextLabel.text = self.item.detail;
    }
    
    if (_item.detailAttributeString) {
        self.detailTextLabel.attributedText = self.item.detailAttributeString;
    }
    
    if (_item.customerView) {
        [self addSubview:self.item.customerView];
    }
    
    if (_item.rightContentImage) {
        [self.contentView addSubview:self.rightContentImageView];
    } else {
        [self _setupAccessoryDisclosureIndicator];
    }
    
    if (_item.rightContentButton) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = _item.rightContentButton;
    } else {
        [self _setupAccessoryDisclosureIndicator];
    }
    
    // 开关
    if (_item.switchValue != KKStaticCellSwitchValueNone) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = self.rightContentSwitchView;
        
        if (_item.switchValue == KKStaticCellSwitchValueDefault && IsValidateString(self.item.title)) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            self.rightContentSwitchView.on = [defaults boolForKey:self.item.title];
        } else {
            self.rightContentSwitchView.on = _item.switchValue;
        }
    }
}

- (void)_setupAccessoryDisclosureIndicator {
    if (_item.isShowIndicator) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)_setupType {
    switch (_item.cellType) {
        case KKStaticCellTypeCheckMark: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        }
            
        default: {
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
    }
}

#pragma mark - setter

#pragma mark - getter

- (UISwitch *)rightContentSwitchView {
    if (!_rightContentSwitchView) {
        _rightContentSwitchView = [[UISwitch alloc] init];
        [_rightContentSwitchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _rightContentSwitchView;
}

- (void)switchStateChange {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.rightContentSwitchView.isOn forKey:self.item.title];
    [defaults synchronize];
    
    if (self.rightContentSwitchView && self.item.switchValueChangeHandle) {
        self.item.switchValueChangeHandle(self.rightContentSwitchView);
    }
}

- (UIImageView *)rightContentImageView {
    if (!_rightContentImageView) {
        _rightContentImageView = [UIImageView new];
        _rightContentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    _rightContentImageView.image = self.item.rightContentImage;
    return _rightContentImageView;
}

- (UIView *)divider {
    if (!_divider) {
        _divider = [[UIView alloc] init];
        _divider.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    return _divider;
}

- (void)_setSelectedBgColor:(UIColor *)color {
    if (!_selectedBgView) {
        _selectedBgView = [[UIView alloc] initWithFrame:self.selectedBackgroundView.bounds];
        _selectedBgView.backgroundColor = color;
    }
    [self.selectedBackgroundView addSubview:_selectedBgView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerY = 0;
    CGFloat dividerH = kStaticCellDeviderH;
    CGFloat dividerW = [UIScreen mainScreen].bounds.size.width;
    
    if (self.isShowBgDivider) {
        self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    } else {
        self.divider.frame = CGRectZero;
    }
    
    if (self.item.icon) {
        CGFloat imageViewWH = 20;
        CGFloat imageViewX = self.imageView.frame.origin.x;
        CGFloat imageViewY = self.imageView.center.y - imageViewWH * 0.5;
        self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);
        
        // 图片不标准时，可能引发 title 的错位
        if (self.item.title) {
            CGFloat x = self.textLabel.frame.origin.x;
            CGFloat y = self.textLabel.frame.origin.y;
            CGFloat w = self.textLabel.frame.size.width;
            CGFloat h = self.textLabel.frame.size.height;
            self.textLabel.frame = CGRectMake(x, y, w, h);
        }
    }
    
    if (self.isShowSeperator == NO) {
        for (UIView *subview in self.contentView.superview.subviews) {
            if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
                subview.hidden = YES;
            }
        }
    }
}

@end
