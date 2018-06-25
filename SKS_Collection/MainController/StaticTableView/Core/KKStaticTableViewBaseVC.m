//
//  StaticTableViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "KKStaticTableViewBaseVC.h"
#import "KKStaticCell.h"
#import "CommonMacro.h"
#import "UIView+CornerRadio.h"
#import "UIViewController+InstanceFromClass.h"
#import "UITableView+RadioCornerCell.h"

@interface KKStaticTableViewBaseVC() <UITableViewDelegate, UITableViewDataSource, StaticCellDelegate> {
    NSInteger _selectedIndex;
}

@end

@implementation KKStaticTableViewBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self addNotification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:kStaticCellUpdataNofication
                                               object:nil ];
}

- (void)refreshData:(NSNotification *)notification {
    NSLog(@"%s", __func__);
    [self.tableView reloadData];
}

# pragma mark abstract mathod

- (UIView *)viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)setupStaticCellAppearence:(KKStaticCell *)cell {
    
}

#pragma setter, getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:[self tableViewStyle]];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = kStaticCellH;
        tableView.alwaysBounceVertical = YES;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.backgroundView = nil;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KKStaticCellItem *item = self.dataArray[indexPath.section].items[indexPath.row];
    
    if (item.customerView) {
        return item.customerView.bounds.size.height;
    }
    
    CGSize size = item.cellSize;
    return size.height > 0 ? size.height : tableView.rowHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataArray[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.dataArray[section].footerTitle;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(KKStaticCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor whiteColor];
    
    BOOL isLastCell = indexPath.row == self.dataArray[indexPath.section].items.count - 1 && indexPath.section == self.dataArray.count - 1;
    
    // 最后一个 cell 不显示分割线
    cell.isShowSeperator = !isLastCell;
    
    if (self.isShowCornerRadio) {
        [tableView setCornerRadio:8.0 cell:cell atIndexPath:indexPath selectedBgColor:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KKStaticCellItemGroup *group = self.dataArray[indexPath.section];
    KKStaticCellItem *item = group.items[indexPath.row];
    
    UITableViewCellStyle style;
    if (item.detail != nil || item.detailAttributeString != nil) {
        style = UITableViewCellStyleValue1;
    } else {
        style = UITableViewCellStyleDefault;
    }
    
    // 因为每个 cell 都可能不同，所以不使用 cell 重用。所以本框架不适用于数据量很大的情况
    KKStaticCell *cell = [[KKStaticCell alloc] initWithStyle:style reuseIdentifier:@""];
    cell.delegate = self;
    
    // 多选、单选、可取消的单选状态下，默认选中的 item
    BOOL shouldShowCheckMark = group.defaultSelectedIndex == indexPath.row
                        && (group.type == GroupTypeSingleCheckMarkCanCancle
                        ||  group.type == GroupTypeMultipleCheckMark
                        ||  group.type == GroupTypeSingleCheckMark);
    if (shouldShowCheckMark) {
        group.defaultSelectedIndex = -1;
        item.cellType = KKStaticCellTypeCheckMark;
        _selectedIndex = indexPath.row;
        
        [group.selectedIndexPaths addObject:indexPath];
    }
    
    cell.item = item;
    cell.isShowBgDivider = self.isShowBgDivider;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KKStaticCell *cell = (KKStaticCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell.item.isSelectionStyleEnable) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selected = NO;
    }
    
    KKStaticCellItemGroup *group = self.dataArray[indexPath.section];
    KKStaticCellItem *item = group.items[indexPath.row];
    
    if (item.objectClass) {
        UIViewController *controller = [UIViewController controllerWithClass:item.objectClass];
        [self.navigationController pushViewController:controller animated:YES];
        return;
        
    } else if(item.clickedHandle) {
        item.clickedHandle(indexPath);
        return;
    }
    
    // 单选
    if (group.type == GroupTypeSingleCheckMark && _selectedIndex != indexPath.row) {
        group.items[_selectedIndex].cellType = KKStaticCellTypeNone;
        item.cellType = KKStaticCellTypeCheckMark;
        _selectedIndex = indexPath.row;
        
        [group.selectedIndexPaths removeAllObjects];
        [group.selectedIndexPaths addObject:indexPath];
        
        [self.tableView reloadData];
    }
    // 单选，再次选择时取消选择
    else if (group.type == GroupTypeSingleCheckMarkCanCancle) {
        [group.selectedIndexPaths removeAllObjects];

        KKStaticCellType originalType = item.cellType;
        for (KKStaticCellItem *i in group.items) {
            i.cellType = KKStaticCellTypeNone;
        }
        if (originalType == KKStaticCellTypeNone) {
            item.cellType = KKStaticCellTypeCheckMark;
            [group.selectedIndexPaths addObject:indexPath];
        }
        
        [self.tableView reloadData];
    }
    // 多选
    else if (group.type == GroupTypeMultipleCheckMark) {
        if (item.cellType == KKStaticCellTypeNone) {
            item.cellType = KKStaticCellTypeCheckMark;
            [group.selectedIndexPaths addObject:indexPath];
        } else if (item.cellType == KKStaticCellTypeCheckMark) {
            item.cellType = KKStaticCellTypeNone;
            [group.selectedIndexPaths removeObject:indexPath];
        }
        
        [self.tableView reloadData];
    }

    if (group.didSelectedRowBlock) {
        NSArray *array = [group.selectedIndexPaths copy];
        group.didSelectedRowBlock(array);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.dataArray[section].headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.dataArray[section].footerHeight;
}

#pragma - mark Edit

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    KKStaticCellItem *item = self.dataArray[indexPath.section].items[indexPath.row];
    return item.deleteHandle != nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    KKStaticCellItem *item = self.dataArray[indexPath.section].items[indexPath.row];
    if (item.deleteHandle) {
        kk_CellLeftScrollDeleteHandle handleCopy = [item.deleteHandle copy];
        handleCopy(indexPath);
    }
}

# pragma mark - 设置UITableViewSytle
- (UITableViewStyle)tableViewStyle {
    return UITableViewStylePlain;
}

# pragma mark - StaticCellDelegate

- (void)staticCellSetupAppearance:(KKStaticCell *)cell {
    [self setupStaticCellAppearence:cell];
}

@end
