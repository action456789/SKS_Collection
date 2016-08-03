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

@implementation StaticCell

- (void)setItem:(StaticCellItem *)item
{
    _item = item;
    
    [self setupData];
    [self setupRightContent];
}

- (void)setupData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    self.textLabel.text = self.item.title;
    
    if (self.item.subTitle) {
        self.detailTextLabel.text = self.item.subTitle;
    }
}

- (void)setupRightContent
{
    switch (self.item.cellType) {
        case StaticCellTypeDisclosureIndicator:
            [self createCellDisclosure];
            break;
            
        case StaticCellTypeButton:
            [self createCellButton];
            break;
            
        case StaticCellTypeSwitch:
            [self createCellSwitch];
            break;
            
        case StaticCellTypeLabel:
            [self createCellLabel];
            break;
            
        case StaticCellTypeHandle:
            [self createCellHandle];
            break;
            
        default:
            self.accessoryView = nil;
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }

}

- (void)createCellDisclosure
{
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView* myBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    myBackgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = myBackgroundView;
}

- (void)createCellButton
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.accessoryView = self.button;
}

- (void)createCellLabel
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.accessoryView = self.labelView;
}

- (void)createCellSwitch
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.accessoryView = self.switchView;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.switchView.on = [defaults boolForKey:self.item.title];
}

- (void)createCellHandle
{
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

#pragma mark - getter

- (UISwitch *)switchView
{
    if (_switchView == nil) {
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
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.backgroundColor = [UIColor clearColor];
        _labelView.textAlignment = NSTextAlignmentRight;
        _labelView.text = @"我是测试";
    }
    return _labelView;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.textAlignment = NSTextAlignmentLeft;
        _button.bounds = CGRectMake(0, 0, 100, 30);
        
        [_button setTitle:@"sdfsdfsd" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor redColor];
    }
    return _button;
}

@end
