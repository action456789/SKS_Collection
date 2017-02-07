//
//  MyBannerViewController.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/23.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "BanberViewController.h"
#import "BannerView.h"
#import "CommonMacro.h"

@interface BanberViewController ()
@property (nonatomic, strong) BannerView *bannerView;
@end

@implementation BanberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    StaticCollectionViewCellItem *item1 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"banner1" title:nil handle:^{
        NSLog(@"banner1");
    }];
    
    StaticCollectionViewCellItem *item2 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"banner2" title:nil handle:^{
        NSLog(@"banner2");
    }];
    
    StaticCollectionViewCellItem *item3 = [[StaticCollectionViewCellItem alloc] initWithImageName:@"banner3" title:nil handle:^{
        NSLog(@"banner3");
    }];
    
    NSArray *array = @[item1, item2, item3];
    
    BannerView *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) dataArray:array autoScroll:YES];
    [self.view addSubview:bannerView];
    self.bannerView = bannerView;
}


@end
