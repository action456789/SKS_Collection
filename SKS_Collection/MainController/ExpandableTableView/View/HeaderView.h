//
//  QQListHeaderView.h
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModal.h"
@class HeaderView;

@protocol HeaderViewDelegate <NSObject>
@optional
- (void)headerViewDidClicked:(HeaderView *)headerView withSection:(NSInteger)section;
@end


@interface HeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<HeaderViewDelegate> delegate;

@property (nonatomic, strong) ClassModal *classModal;

@property (nonatomic, assign) NSInteger section;

@end
