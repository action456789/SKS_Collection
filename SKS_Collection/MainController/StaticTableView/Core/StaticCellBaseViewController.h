//
//  StaticTableViewController.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "StaticCellItem.h"
#import "StaticCellItemGroup.h"
#import "StaticCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface StaticCellBaseViewController : UIViewController

@property (nonatomic, strong) NSArray<StaticCellItemGroup *> * dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowBgDivider;

/// cell 是否显示圆角:
// 如果一组只有一个cell，cell 四角都是圆角
// 如果一组有多个cell，第一个cell topLeft、topRight 显示圆角。最后一个cell bottomLeft, bottomRight 显示圆角
@property (nonatomic, assign) BOOL isShowCornerRadio;

// 设置圆角后选中时的背景颜色
@property (nonatomic, strong) UIColor * __nullable selectedBgColor;

- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath;

// 抽象方法，由子类重载
- (UIView * __nullable)viewForHeaderInSection:(NSInteger)section;
- (UIView * __nullable)viewForFooterInSection:(NSInteger)section;

// 自定义 TableViewCell 界面风格，如字体等
- (void)setupStaticCellAppearence:(StaticCell *)cell;

// 设置UITableViewStyle，由子类重载
- (UITableViewStyle)tableViewStyle;

@end

NS_ASSUME_NONNULL_END
