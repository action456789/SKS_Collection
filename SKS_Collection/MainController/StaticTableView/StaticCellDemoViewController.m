//
//  StaticCellViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/4/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellDemoViewController.h"

#import "StaticCellBaseViewController.h"
#import "BlurEffectDemoController.h"
#import "UIDevice+KS.h"

@implementation StaticCellDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    
    NSArray *array = @[
       [StaticCellItem itemWithTitle:@"一键优化" type:StaticCellTypeDisclosureIndicator handle:^{[weakSelf gotoRemoteOpimize];}]
       ,[StaticCellItem itemWithTitle:@"家长控制" type:StaticCellTypeDisclosureIndicator handle:^{[weakSelf gotoParentalControls];}]
       ,[StaticCellItem itemWithTitle:@"会员有效期" subTitle:@"2016-12-30"]
       ,[StaticCellItem itemWithTitle:@"卡券兑换" type:StaticCellTypeHandle handle:^{[weakSelf cardVouchersExchange];}]
    ];
    
    NSArray *array2 = @[
         [StaticCellItem itemWithTitle:@"模糊效果" objectClass:[BlurEffectDemoController class]]
        ,[StaticCellItem itemWithTitle:@"儿童锁" type:StaticCellTypeSwitch]
        ,[StaticCellItem itemWithTitle:@"会员有效期" subTitle:@"2016-12-30"]
        ,[StaticCellItem itemWithTitle:@"sdfad" type:StaticCellTypeDisclosureIndicator handle:^{
            NSLog(@"sdfsd");
        }]
        ,[StaticCellItem itemWithTitle:@"一键优化" type:StaticCellTypeButton]
                        ];
    
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
