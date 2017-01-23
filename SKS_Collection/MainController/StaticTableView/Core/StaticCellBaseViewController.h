//
//  StaticTableViewController.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BaseViewController.h"
#import "StaticCellItem.h"
#import "StaticCellItemGroup.h"

@interface StaticCellBaseViewController : UIViewController

- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong) NSArray<StaticCellItemGroup *> *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath;

- (UIView *)tableView:(UITableView *)tableView headerCellInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView footerCellInSection:(NSInteger)section;

@end
