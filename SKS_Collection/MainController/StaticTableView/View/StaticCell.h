//
//  StaticCell.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCellItem;

@interface StaticCell : UITableViewCell

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) StaticCellItem *item;

@end
