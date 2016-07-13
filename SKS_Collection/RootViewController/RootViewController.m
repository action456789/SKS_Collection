//
//  RootViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RootViewController.h"
#import "ListCellItem.h"
#import "CountDownButtonDemoVC.h"
#import "RotateAnimateViewController.h"
#import "ListCell.h"

@interface RootViewController()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray<ListCellItem *> *_dataArray;
}
@end

@implementation RootViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    [self initData];
    
}

- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 50.f;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)initData
{
    _dataArray = @[  [ListCellItem itemWithName:@"倒计时按钮" objectClass:[CountDownButtonDemoVC class]]
                    ,[ListCellItem itemWithName:@"转动动画的暂停与恢复" objectClass:[RotateAnimateViewController class]]
                  ];
    
    [_tableView reloadData];
}

#pragma mark - tableView Delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark - tableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"kCellIdentifier";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row].name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [_dataArray[indexPath.row].objectClass new];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
