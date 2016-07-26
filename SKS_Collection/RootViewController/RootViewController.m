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
#import "SlideTabBarDemoController.h"
#import "BlurEffectDemoController.h"
#import "FileCacheDemoController.h"
#import "DiskCacheSqlLiteDemoController.h"
#import "GradientLayerDemoController.h"
#import "GradientLayerDemo2Controller.h"
#import "QRCodeViewController.h"
#import "ShimmerDemeController.h"
#import "WKWebViewDemoController.h"

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface RootViewController()<UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray<ListCellItem *> *_dataSourceArray;
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50.f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ListCell class] forCellReuseIdentifier:kCellIdentifier];
    [self.view addSubview:_tableView];
}

- (void)initData
{
    _dataSourceArray = @[  [ListCellItem itemWithName:@"倒计时按钮" objectClass:[CountDownButtonDemoVC class]]
                           ,[ListCellItem itemWithName:@"转动动画的暂停与恢复" objectClass:[RotateAnimateViewController class]]
                           ,[ListCellItem itemWithName:@"Slide Tab Bar" objectClass:[SlideTabBarDemoController class]]
                           ,[ListCellItem itemWithName:@"模糊效果" objectClass:[BlurEffectDemoController class]]
                           ,[ListCellItem itemWithName:@"文件缓存" objectClass:[FileCacheDemoController class]]
                           ,[ListCellItem itemWithName:@"sqlite缓存" objectClass:[DiskCacheSqlLiteDemoController class]]
                           ,[ListCellItem itemWithName:@"GradientLayer(渐变梯度图层)" objectClass:[GradientLayerDemoController class]]
                           ,[ListCellItem itemWithName:@"GradientLayer动画" objectClass:[GradientLayerDemo2Controller class]]
                           ,[ListCellItem itemWithName:@"扫描二维码" objectClass:[QRCodeViewController class]]
                           ,[ListCellItem itemWithName:@"辉光动画" objectClass:[ShimmerDemeController class]]
                           ,[ListCellItem itemWithName:@"WKWebView的加载过程" objectClass:[WKWebViewDemoController class]]
                           ];
}

#pragma mark - tableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

#pragma mark - tableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    cell.textLabel.text = _dataSourceArray[indexPath.row].name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [_dataSourceArray[indexPath.row].objectClass new];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
