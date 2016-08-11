//
//  QQListHeaderView.m
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "HeaderView.h"
#import <Masonry.h>

@implementation HeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    if (headerView == nil) {
        headerView = [[HeaderView alloc] initWithReuseIdentifier:@"headerCell"];
        headerView.backgroundColor = [UIColor grayColor];
    }
    return headerView;
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
    self.textLabel.text = classModal.name;
}


@end
