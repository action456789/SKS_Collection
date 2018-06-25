//
//  StaticCell.h
//  SKS_Collection
//
//  Created by KeSen on 8/3/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKStaticCellItem;
@class KKStaticCell;

#define kStaticCellH 50.f
#define kStaticCellDeviderH 5

@protocol StaticCellDelegate <NSObject>
@optional
- (void)staticCellSetupAppearance:(KKStaticCell *)cell;
@end

@interface KKStaticCell : UITableViewCell

@property (nonatomic,weak) id<StaticCellDelegate> delegate;

@property (nonatomic, strong) KKStaticCellItem *item;

@property (nonatomic, assign) BOOL isShowBgDivider;

@property (nonatomic, assign) BOOL isShowSeperator;

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, strong) UIButton *rightContentButton;

@end
