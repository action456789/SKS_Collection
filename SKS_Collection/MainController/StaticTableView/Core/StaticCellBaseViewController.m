//
//  StaticTableViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellBaseViewController.h"
#import "StaticCell.h"
#import "CommonMacro.h"

#define kCellIdentifie @"StaticCell"

@interface StaticCellBaseViewController() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation StaticCellBaseViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        self.tableViewStyle = style;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self addNotification];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:kStaticCellUpdataNofication
                                               object:nil ];
}

- (void)refreshData:(NSNotification *)notification
{
    [self.tableView reloadData];
}

# pragma mark abstract mathod

- (UIView *)tableView:(UITableView *)tableView headerViewInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView footerViewInSection:(NSInteger)section
{
    return nil;
}

- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma setter, getter

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:self.tableViewStyle];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = kStaticCellH;
        tableView.alwaysBounceVertical = YES;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [tableView setSeparatorColor:[UIColor cyanColor]];
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
    cell.backgroundColor = [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaticCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifie];
    if (!cell) {
        cell = [[StaticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifie];
    }
    
    cell.item = self.dataArray[indexPath.section].items[indexPath.row];
    
    if (cell.item.cellType == StaticCellTypeButton) {
        [self configureCellButton:cell.rightContentButton atIndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StaticCellItem *item = self.dataArray[indexPath.section].items[indexPath.row];
    
    if (item.objectClass) {
        UIViewController *controller = [item.objectClass new];
        [self.navigationController pushViewController:controller animated:YES];
    } else if(item.clickedHandle) {
        item.clickedHandle();
    }
}

- (UIView *)tableView:(UITableView *)tableView headerCellInSection:(NSInteger)section
{
    return [self tableView:tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView footerCellInSection:(NSInteger)section
{
    return [self tableView:tableView viewForFooterInSection:section];
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
