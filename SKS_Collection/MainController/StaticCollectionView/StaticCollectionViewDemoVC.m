//
//  StaticCollectionViewDemoVC.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/13.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "StaticCollectionViewDemoVC.h"
#import "StaticCollectionView.h"
#import "StaticCollectionViewCellItem.h"
#import "CommonMacro.h"

@interface StaticCollectionViewDemoVC ()

@end

@implementation StaticCollectionViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[  [[StaticCollectionViewCellItem alloc] initWithImageName:@"最优策略" title:@"最优策略"]
                       , [[StaticCollectionViewCellItem alloc] initWithImageName:@"优品评测" title:@"优品评测"]
                       , [[StaticCollectionViewCellItem alloc] initWithImageName:@"相似K线" title:@"相似K线"]
                       , [[StaticCollectionViewCellItem alloc] initWithImageName:@"添加预警" title:@"添加预警"]
                       , [[StaticCollectionViewCellItem alloc] initWithImageName:@"股价预测" title:@"股价预测"]
                       , [[StaticCollectionViewCellItem alloc] initWithImageName:@"更多分享" title:@"更多分享"]
                       ];
    
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(kScreenWidth / 4, 88);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout;
    });
    
    StaticCollectionView *collectionView = [[StaticCollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight)
                                                                                layout:flowLayout
                                                                             dataArray:array];
    
    [self.view addSubview:collectionView];
}

@end
