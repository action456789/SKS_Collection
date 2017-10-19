//
//  StaticCollectionViewCell.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StaticCollectionViewCellItem;

@interface StaticCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) StaticCollectionViewCellItem *dataModal;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
