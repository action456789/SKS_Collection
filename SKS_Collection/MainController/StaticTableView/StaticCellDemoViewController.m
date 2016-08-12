//
//  StaticCellViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/4/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellDemoViewController.h"

#import "BlurEffectDemoController.h"
#import "UIDevice+KS.h"

@implementation StaticCellDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    
    StaticCellItem *item1 = [StaticCellItem itemWithTitle:@"一键优化" icon:nil type:StaticCellTypeDisclosureIndicator handle:^{[weakSelf gotoRemoteOpimize];}];
    StaticCellItem *item2 = [StaticCellItem itemWithTitle:@"家长控制" icon:nil type:StaticCellTypeDisclosureIndicator handle:^{[weakSelf gotoParentalControls];}];
    StaticCellItem *item3 = [StaticCellItem itemWithTitle:@"会员有效期" icon:nil subTitle:@"2016-12-30"];
    StaticCellItem *item4 = [StaticCellItem itemWithTitle:@"卡券兑换" icon:nil type:StaticCellTypeHandle handle:^{[weakSelf cardVouchersExchange];}];
    
    StaticCellItem *item5 = [StaticCellItem itemWithTitle:@"模糊效果" icon:nil objectClass:[BlurEffectDemoController class]];
    StaticCellItem *item6 = [StaticCellItem itemWithTitle:@"儿童锁" icon:nil type:StaticCellTypeSwitch];
    StaticCellItem *item7 = [StaticCellItem itemWithTitle:@"会员有效期" icon:nil subTitle:@"2016-12-30"];
    StaticCellItem *item8 = [StaticCellItem itemWithTitle:@"sdfad" icon:nil type:StaticCellTypeDisclosureIndicator handle:^{
        NSLog(@"sdfsd");
    }];
    StaticCellItem *item9 = [StaticCellItem itemWithTitle:@"一键优化" icon:nil type:StaticCellTypeButton];
    
    NSArray *array = @[item1, item2, item3, item4];
    NSArray *array2 = @[item5, item6, item7, item8, item9];
         
    StaticCellItemGroup *group1 = [StaticCellItemGroup itemGroupWithHeaderTitle:@"第一组"
                                                                   headerHeight:100
                                                                    footerTitle:nil
                                                                   footerHeight:0
                                                                          items:array];
    
    StaticCellItemGroup *group2 = [StaticCellItemGroup itemGroupWithHeaderTitle:nil
                                                                   headerHeight:20
                                                                    footerTitle:nil
                                                                   footerHeight:100
                                                                          items:array2];
    
    self.dataArray = @[group1, group2];
}

- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath
{
    if (cellButton) {
        cellButton.layer.masksToBounds = YES;
        cellButton.layer.cornerRadius = 2.f;
        cellButton.layer.borderColor = [UIColor grayColor].CGColor;
        cellButton.layer.borderWidth = 1.f;
        cellButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 4) { // 一键优化
            [cellButton setTitle:@"开始" forState:UIControlStateNormal];
            [cellButton addTarget:self action:@selector(gotoRemoteOpimize) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)gotoRemoteOpimize
{
    NSLog(@"%s", __func__);
}

- (void)gotoParentalControls
{
    NSLog(@"%s", __func__);
}

- (void)cardVouchersExchange
{
    NSLog(@"%s", __func__);
}

- (UIView *)tableView:(UITableView *)tableView headerCellInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerCell"];
    view.bounds = CGRectMake(0, 0, ScreenWidth, 200);
    return view;
}
                                      
- (UIView *)tableView:(UITableView *)tableView footerCellInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerCell"];
    view.bounds = CGRectMake(0, 0, ScreenWidth, 200);
    return view;
}

@end
