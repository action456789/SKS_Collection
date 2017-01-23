//
//  StaticCell.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCell.h"
#import "StaticCellItem.h"

@interface StaticCell()

@property (nonatomic, strong) UISwitch *rightContentSwitchView;
@property (nonatomic, strong) UILabel *rightContentLabel;
@property (nonatomic, copy) StaticCellHandle cellClickedHandle;

@property (nonatomic, strong) UIView *divider;

@end

// 这里最好用懒加载，因为所有控件只在特定的 cell 类型下才会使用

@implementation StaticCell
{
    UIView *_selectedBgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.divider];
    }
    return self;
}

- (void)setItem:(StaticCellItem *)item
{
    _item = item;
    
    [self _setupData];
    [self _setupRightContent];
}

- (void)_setupData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    if (self.item.title) {
        self.textLabel.text = self.item.title;
    }
}

- (void)_setupRightContent
{
    switch (self.item.cellType) {
        case StaticCellTypeDisclosureIndicator: {
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
            
        case StaticCellTypeButton: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.accessoryView = self.rightContentButton;
            break;
        }
            
        case StaticCellTypeSwitch: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.accessoryView = self.rightContentSwitchView;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            self.rightContentSwitchView.on = [defaults boolForKey:self.item.title];
            
            break;
        }
            
        case StaticCellTypeLabel: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.accessoryView = self.rightContentLabel;
            self.rightContentLabel.text = self.item.subTitle;
            
            break;
        }
            
        case StaticCellTypeHandle: {
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
            break;
        }
            
        default: {
            self.accessoryView = nil;
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
    }
}

#pragma mark - getter

- (UISwitch *)rightContentSwitchView
{
    if (!_rightContentSwitchView) {
        _rightContentSwitchView = [[UISwitch alloc] init];
        [_rightContentSwitchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _rightContentSwitchView;
}

- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.rightContentSwitchView.isOn forKey:self.item.title];
    [defaults synchronize];
}

- (UILabel *)rightContentLabel
{
    if (!_rightContentLabel) {
        _rightContentLabel = [[UILabel alloc] init];
        _rightContentLabel.bounds = CGRectMake(0, 0, 100, 30);
        _rightContentLabel.backgroundColor = [UIColor clearColor];
        _rightContentLabel.textAlignment = NSTextAlignmentCenter;
        _rightContentLabel.text = self.item.subTitle;
        _rightContentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rightContentLabel;
}

- (UIButton *)rightContentButton
{
    if (!_rightContentButton) {
        _rightContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightContentButton.bounds = CGRectMake(0, 0, 100, 30);
    }
    return _rightContentButton;
}

- (UIView *)divider
{
    if (!_divider) {
        _divider = [[UIView alloc] init];
        _divider.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    return _divider;
}

- (void)_setSelectedBgColor:(UIColor *)color
{
    if (!_selectedBgView) {
        _selectedBgView = [[UIView alloc] initWithFrame:self.selectedBackgroundView.bounds];
        _selectedBgView.backgroundColor = color;
    }
    [self.selectedBackgroundView addSubview:_selectedBgView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerY = 0;
    CGFloat dividerH = kStaticCellDeviderH;
    CGFloat dividerW = [UIScreen mainScreen].bounds.size.width;
    
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    
    [self _setSelectedBgColor:[UIColor redColor]];
    
    if (self.item.icon) {
        CGFloat imageViewWH = 30;
        CGFloat imageViewX = self.imageView.frame.origin.x;
        CGFloat imageViewY = self.imageView.center.y - imageViewWH * 0.5;
        self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);
        
        if (self.item.title) {
            CGFloat x = self.textLabel.frame.origin.x - imageViewWH;
            CGFloat y = self.textLabel.frame.origin.y;
            CGFloat w = self.textLabel.frame.size.width;
            CGFloat h = self.textLabel.frame.size.height;
            self.textLabel.frame = CGRectMake(x, y, w, h);
        }
    }
}

@end
