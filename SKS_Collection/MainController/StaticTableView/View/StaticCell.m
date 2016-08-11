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

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UILabel *labelView;
@property (nonatomic, copy) StaticCellHandle handle;

@end

// 这里最好用懒加载，因为所有控件只在特定的 cell 类型下才会使用

@implementation StaticCell
{
    UIView *_selectedBgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
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
    
    [self _setSelectedBgColor:[UIColor redColor]];
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
    
    self.textLabel.text = self.item.title;
    
    if (self.item.subTitle) {
        self.detailTextLabel.text = self.item.subTitle;
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
            self.accessoryView = self.button;
            break;
        }
            
        case StaticCellTypeSwitch: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.accessoryView = self.switchView;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            self.switchView.on = [defaults boolForKey:self.item.title];
            
            break;
        }
            
        case StaticCellTypeLabel: {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.accessoryView = self.labelView;
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

- (UISwitch *)switchView
{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
}

- (UILabel *)labelView
{
    if (!_labelView) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.backgroundColor = [UIColor clearColor];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.text = self.item.subTitle;
        _labelView.font = [UIFont systemFontOfSize:14];
    }
    return _labelView;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.bounds = CGRectMake(0, 0, 100, 30);
    }
    return _button;
}

@end
