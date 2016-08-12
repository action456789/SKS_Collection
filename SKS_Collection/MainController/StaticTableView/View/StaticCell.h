//
//  StaticCell.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCellItem;

#define kStaticCellH 50.f
#define kStaticCellDeviderH 5

@interface StaticCell : UITableViewCell

@property (nonatomic, strong) UIButton *rightContentButton;

@property (nonatomic, strong) StaticCellItem *item;

@end
