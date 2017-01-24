//
//  StaticCollectionView.h
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticCollectionViewCellItem.h"

@interface StaticCollectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layOut dataArray:(NSArray *)dataArray;

// 静态单元格
// 设置 cell 的图片 UIViewContentMode
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;

// 循环滚动视图
@property (nonatomic, assign) BOOL pageEnable;
@property (nonatomic, assign) BOOL infiniteLoop;

- (void)reloadData;

@end
