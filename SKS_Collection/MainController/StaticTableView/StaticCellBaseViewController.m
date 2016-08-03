//
//  StaticTableViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellBaseViewController.h"
#import "StaticCell.h"
#import "StaticCellItem.h"
#import "StaticCellItemGroup.h"

#import "BlurEffectDemoController.h"

#define kCellIdentifie @"StaticCell"

@implementation StaticCellBaseViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.rowHeight = 50.f;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.tableView registerClass:[StaticCell class] forCellReuseIdentifier:kCellIdentifie];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = @[[StaticCellItem itemWithTitle:@"模糊效果" objectClass:[BlurEffectDemoController class]]
                       ,[StaticCellItem itemWithTitle:@"儿童锁" type:StaticCellTypeSwitch]
                       ,[StaticCellItem itemWithTitle:@"会员有效期" subTitle:@"2016-12-30"]
                       ,[StaticCellItem itemWithTitle:@"测试4" handle:^{ NSLog(@"点我啊"); }]
                       ,[StaticCellItem itemWithTitle:@"一键优化" type:StaticCellTypeButton]
                       ];
    
    NSArray *array2 = @[[StaticCellItem itemWithTitle:@"模糊效果" objectClass:[BlurEffectDemoController class]]
                       ,[StaticCellItem itemWithTitle:@"儿童锁" type:StaticCellTypeSwitch]
                       ,[StaticCellItem itemWithTitle:@"会员有效期" subTitle:@"2016-12-30"]
                       ,[StaticCellItem itemWithTitle:@"测试4" handle:^{ NSLog(@"点我啊"); }]
                       ,[StaticCellItem itemWithTitle:@"一键优化" type:StaticCellTypeButton]
                       ];
    
    StaticCellItemGroup *group1 = [StaticCellItemGroup itemGroupWithHeaderTitle:@"第一组" footerTitle:nil items:array];
    StaticCellItemGroup *group2 = [StaticCellItemGroup itemGroupWithHeaderTitle:@"第二组" footerTitle:nil items:array2];
    
    self.dataSource = @[group1, group2];
}

- (void)buttonClick
{
    NSLog(@"%s", __func__);
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource[section].items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.dataSource[section].footerTitle;
}

#pragma mark - tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaticCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifie];
    if (!cell) {
        cell = [[StaticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifie];
    }
    
    cell.item = self.dataSource[indexPath.section].items[indexPath.row];
    
    if (cell.item.cellType == StaticCellTypeButton) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(configureCellButton:atIndexPath:)]) {
            [self.delegate configureCellButton:cell.button atIndexPath:indexPath];;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StaticCellItem *item = self.dataSource[indexPath.section].items[indexPath.row];
    
    if (item.objectClass) {
        UIViewController *controller = [item.objectClass new];
        [self.navigationController pushViewController:controller animated:YES];
    } else if(item.handle) {
        item.handle();
    }
}

@end
