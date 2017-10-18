//
//  StaticCell.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCellItem;

#define kStaticCellH 45.f
#define kStaticCellDeviderH 5

@interface StaticCell : UITableViewCell

@property (nonatomic, strong) StaticCellItem *item;

@property (nonatomic, assign) BOOL isShowBgDivider;

@property (nonatomic, assign) BOOL isShowSeperator;

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, strong) UIButton *rightContentButton;

@end
