//
//  StaticTableViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellBaseViewController.h"
#import "StaticCell.h"

#define kCellIdentifie @"StaticCell"

@interface StaticCellBaseViewController() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation StaticCellBaseViewController
{
    UITableViewStyle _style;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

# pragma mark abstract mathod

- (UIView *)viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)shouldNavigationWhenClickedCellAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma setter, getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:_style];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = kStaticCellHeight;
        tableView.alwaysBounceVertical = YES;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [tableView setSeparatorColor:[UIColor greenColor]];
        [tableView registerClass:[StaticCell class] forCellReuseIdentifier:kCellIdentifie];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray[section].items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataArray[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.dataArray[section].footerTitle;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor lightGrayColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaticCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifie];
    if (!cell) {
        cell = [[StaticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifie];
    }
    
    cell.item = self.dataArray[indexPath.section].items[indexPath.row];
    
    if (cell.item.cellType == StaticCellTypeButton) {
        [self configureCellButton:cell.button atIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StaticCellItem *item = self.dataArray[indexPath.section].items[indexPath.row];
    
    if (item.objectClass && [self shouldNavigationWhenClickedCellAtIndexPath:indexPath]) {
        UIViewController *controller = [item.objectClass new];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.dataArray[section].headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.dataArray[section].footerHeight;
}
@end
