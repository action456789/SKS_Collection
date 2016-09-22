//
//  QQListHeaderView.m
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "HeaderView.h"
#import <Masonry.h>
#import "CommonMacro.h"
#import "UIView+Frame.h"

@implementation HeaderView
{
    UILabel *_normalTitleLable;
    UILabel *_highlightTitleLable;
}

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (headerView == nil) {
        headerView = [[HeaderView alloc] initWithReuseIdentifier:@"headerCell"];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self _buildSubviews];
        
        self.backgroundView = ({ // 设置背景色, iOS8,9...
            UIView * view = [[UIView alloc] initWithFrame:self.bounds];
            view.backgroundColor = [UIColor colorWithWhite: 0.5 alpha:0.8];
            view;
        });
        
        
    }
    return self;
}

- (void)_buildSubviews
{
    // 白色背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadViewW)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    // 灰色背景
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, kScreenWidth, kHeadViewW - 4)];
    contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    [self addSubview:contentView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line1.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [contentView addSubview:line1];
    
    UIView *line2         = [[UIView alloc] initWithFrame:CGRectMake(0, kHeadViewW - 8 + 0.5, kScreenWidth, 0.5)];
    line2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [contentView addSubview:line2];
    
    // 标题
    _normalTitleLable = ({
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, kHeadViewW * 0.7)];
        lable.centerY = contentView.centerY;
        [contentView addSubview:lable];
        lable;
    });
    
    _highlightTitleLable = ({
        UILabel *lable = [[UILabel alloc] initWithFrame:_normalTitleLable.frame];
        lable.textColor = [UIColor redColor];
        lable.alpha = 0;
        [contentView addSubview:lable];
        lable;
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewDidClicked:withSection:)]) {
        [self.delegate headerViewDidClicked:self withSection:self.section];
    }
}

- (void)setClassModal:(ClassModal *)classModal
{
    _classModal = classModal;
    
    _normalTitleLable.text = classModal.name;
    _highlightTitleLable.text = classModal.name;
}

- (void)startAnimationNormal
{
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _normalTitleLable.alpha = 1.f;
        _normalTitleLable.x -= 10;
        _highlightTitleLable.alpha = 0.f;
        _highlightTitleLable.x -= 10;
        
    } completion:nil];
}

- (void)startAnimationExtend
{

    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _normalTitleLable.alpha = 0.f;
        _normalTitleLable.x += 10;
        _highlightTitleLable.alpha   = 1.f;
        _highlightTitleLable.x += 10;
        
    } completion:nil];
}

@end
