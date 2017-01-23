//
//  MyBannerViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "MyBannerViewController.h"
#import "StaticCollectionView.h"
#import "CommonMacro.h"

/* TODO
1. UICollectionViewCell 初始化方法
2. KVO 崩溃
3. UICollectionViewCell 位置不对，向上偏移了
*/

@interface MyBannerViewController ()

@end

@implementation MyBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    StaticCollectionViewCellItem *item1 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"optimizest" title:nil handle:^{
        NSLog(@"最优策略");
    }];
    
    StaticCollectionViewCellItem *item2 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"KLine" title:nil handle:^{
        NSLog(@"相似K线");
    }];
    StaticCollectionViewCellItem *item3 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"alert" title:nil handle:^{
        NSLog(@"添加预警");
    }];
    StaticCollectionViewCellItem *item4 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"forecast" title:nil handle:^{
        NSLog(@"股价预测");
    }];
    StaticCollectionViewCellItem *item5 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"share" title:nil handle:^{
        NSLog(@"更多分享");
    }];
    StaticCollectionViewCellItem *item6 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"evaluate" title:nil handle:^{
        NSLog(@"优品评测");
    }];
    
    
    NSArray *array = @[item1, item2, item3, item4, item5, item6];
    
    UICollectionViewFlowLayout *flowLayout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenWidth, 200);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        layout;
    });
    
    StaticCollectionView *collectionView = [[StaticCollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 200)
                                                                                layout:flowLayout
                                                                             dataArray:array];
    collectionView.imageViewContentMode = UIViewContentModeScaleToFill;
    collectionView.pageEnable = YES;
    
    [self.view addSubview:collectionView];
}


@end
