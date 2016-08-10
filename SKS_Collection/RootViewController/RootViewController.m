//
//  RootViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RootViewController.h"
#import "CountDownButtonDemoVC.h"
#import "RotateAnimateViewController.h"
#import "KKSlideTabBarViewController.h"
#import "BlurEffectDemoController.h"
#import "FileCacheDemoController.h"
#import "DiskCacheSqlLiteDemoController.h"
#import "GradientLayerDemoController.h"
#import "GradientLayerDemo2Controller.h"
#import "QRCodeViewController.h"
#import "ShimmerDemeController.h"
#import "WKWebViewDemoController.h"
#import "StaticCellDemoViewController.h"
#import "NumberIncresingVc.h"
#import "CheckMarkAnimVc.h"

@interface RootViewController()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData
{
    NSArray *items = @[ [StaticCellItem itemWithTitle:@"倒计时按钮" objectClass:[CountDownButtonDemoVC class]]
                        ,[StaticCellItem itemWithTitle:@"转动动画的暂停与恢复" objectClass:[RotateAnimateViewController class]]
                        ,[StaticCellItem itemWithTitle:@"Slide Tab Bar" objectClass:[KKSlideTabBarViewController class]]
                        ,[StaticCellItem itemWithTitle:@"模糊效果" objectClass:[BlurEffectDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"文件缓存" objectClass:[FileCacheDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"sqlite缓存" objectClass:[DiskCacheSqlLiteDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"GradientLayer(渐变梯度图层)" objectClass:[GradientLayerDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"GradientLayer动画" objectClass:[GradientLayerDemo2Controller class]]
                        ,[StaticCellItem itemWithTitle:@"扫描二维码" objectClass:[QRCodeViewController class]]
                        ,[StaticCellItem itemWithTitle:@"辉光动画" objectClass:[ShimmerDemeController class]]
                        ,[StaticCellItem itemWithTitle:@"WKWebView的加载过程" objectClass:[WKWebViewDemoController class]]
                        ,[StaticCellItem itemWithTitle:@"静态单元格" objectClass:[StaticCellDemoViewController class]]
                        ,[StaticCellItem itemWithTitle:@"数字增长动画" objectClass:[NumberIncresingVc class]]
                        ,[StaticCellItem itemWithTitle:@"√ × 动画" objectClass:[CheckMarkAnimVc class]]
                        ];
    
    StaticCellItemGroup *group = [StaticCellItemGroup itemGroupWithHeaderTitle:nil
                                                                  headerHeight:0
                                                                   footerTitle:nil
                                                                  footerHeight:0
                                                                         items:items];
    
    self.dataArray = @[group];
}

@end
