//
//  StaticTableViewController.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BaseViewController.h"
@class StaticCellItemGroup;

@protocol StaticCellBaseViewControllerDelegate <NSObject>
@optional
- (void)configureCellButton:(UIButton *)cellButton atIndexPath:(NSIndexPath *)indexPath;
@end

@interface StaticCellBaseViewController : UITableViewController

@property (nonatomic, strong) NSArray<StaticCellItemGroup *> *dataSource;

@property (nonatomic,weak) id <StaticCellBaseViewControllerDelegate> delegate;

@end
