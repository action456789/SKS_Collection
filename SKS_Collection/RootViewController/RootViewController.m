//
//  RootViewController.m
//  SKS_Collection
//
//  Created by KeSen on 7/12/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "RootViewController.h"
#import "RotateAnimateViewController.h"
#import "KKSegmentControlVC.h"
#import "BlurEffectDemoController.h"
#import "FileCacheDemoController.h"
#import "DiskCacheSqlLiteDemoController.h"
#import "GradientLayerDemoController.h"
#import "GradientLayerDemo2Controller.h"
#import "QRCodeViewController.h"
#import "ShimmerDemeController.h"
#import "WKWebViewDemoController.h"
#import "NumberIncresingVc.h"
#import "CheckMarkAnimVc.h"
#import "ExpandableViewController.h"
#import "GifDemoViewController.h"
#import "CaculaterViewController.h"
#import "SearchDemoController.h"
#import "AppleSystemServiceViewController.h"
#import "PhotoToolViewController.h"
#import "SAMKeychainDemoViewController.h"
#import "LocksDemoViewController.h"
#import "CommonMacro.h"
#import "AddClickAreaButtonDemeVC.h"
#import "CycleScrollViewDemoVC.h"
#import "EmptyContentTableViewController.h"
#import "StaticCollectionViewDemo2VC.h"
#import "ModalFromViewController.h"
#import "BanberDemoVC.h"
#import "EjectShrinkBtnsDemoVC.h"
#import "LightControlPannelVC.h"
#import "WeekSelectorVCDemo.h"
#import "ColorSliderDemoVC.h"
#import "TipsViewDemoVC.h"
#import "RiciColorPaletteVC.h"
#import "UIImageTransformTestVC.h"

// OC 使用 Swift 代码
#import "SKS_Collection-Swift.h"

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
    KKStaticCellItem *item = [KKStaticCellItem itemWithTitle:@"28. 自定义转场动画" icon:nil objectClass:nil];
    item.clickedHandle = ^(NSIndexPath * _Nonnull indexPath) {
        ModalFromViewController *vc = [[ModalFromViewController alloc] initWithNibName:@"ModalFromViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    NSArray *items = @[ [KKStaticCellItem itemWithTitle:@" 1. 倒计时按钮" icon:nil     objectClass:[CountDownBtnDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"2. 转动动画的暂停与恢复" icon:nil objectClass:[RotateAnimateViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"3. Slide Tab Bar" icon:nil objectClass:[KKSegmentControlDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"4. 模糊效果" icon:nil objectClass:[BlurEffectDemoController class]]
                        ,[KKStaticCellItem itemWithTitle:@"5. 文件缓存" icon:nil objectClass:[FileCacheDemoController class]]
                        ,[KKStaticCellItem itemWithTitle:@"6. sqlite缓存" icon:nil objectClass:[DiskCacheSqlLiteDemoController class]]
                        ,[KKStaticCellItem itemWithTitle:@"7. GradientLayer(渐变梯度图层)" icon:nil objectClass:[GradientLayerDemoController class]]
                        ,[KKStaticCellItem itemWithTitle:@"8. GradientLayer动画" icon:nil objectClass:[GradientLayerDemo2Controller class]]
                        ,[KKStaticCellItem itemWithTitle:@"9. 扫描二维码" icon:nil objectClass:[QRCodeViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"10. 辉光动画" icon:nil objectClass:[ShimmerDemeController class]]
                        ,[KKStaticCellItem itemWithTitle:@"11. WKWebView的加载过程" icon:nil objectClass:[WKWebViewDemoController class]]
                        ,[KKStaticCellItem itemWithTitle:@"12. 静态单元格" icon:nil objectClass:[FeedBackViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"13. 数字增长动画" icon:nil objectClass:[NumberIncresingVc class]]
                        ,[KKStaticCellItem itemWithTitle:@"14. CALayer动画" icon:nil objectClass:[CheckMarkAnimVc class]]
                        ,[KKStaticCellItem itemWithTitle:@"15. 可展开的班级学生列表" icon:nil objectClass:[ExpandableViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"16. TipsView" icon:nil objectClass:[TipsViewDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"17. 加载 gif 图片" icon:nil objectClass:[GifDemoViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"18. 链式编程-计算器" icon:nil objectClass:[CaculaterViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"19. UISearchController" icon:nil objectClass:[SearchDemoController class]]
                        ,[KKStaticCellItem itemWithTitle:@"20. 苹果系统服务" icon:nil objectClass:[AppleSystemServiceViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"21. 照片工具类" icon:nil objectClass:[PhotoToolViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"22. SAMKeychain" icon:nil objectClass:[SAMKeychainDemoViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"23. Locks" icon:nil objectClass:[LocksDemoViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"24. 增加按钮点击区域" icon:nil objectClass:[AddClickAreaButtonDemeVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"25. 无限滚动" icon:nil objectClass:[CycleScrollViewDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"24. 无数据视图" icon:nil objectClass:[EmptyContentTableViewController class]]
                        ,[KKStaticCellItem itemWithTitle:@"25. 静态CollectionViewCell demo1 无限循环View" icon:nil objectClass:[BanberDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"26. 静态CollectionViewCell demo2" icon:nil objectClass:[StaticCollectionViewDemo2VC class]]
                        ,[KKStaticCellItem itemWithTitle:@"27. 静态CollectionViewCell demo3" icon:nil objectClass:[StaticCollectionViewDemo3VC class]]
                        ,item
                        ,[KKStaticCellItem itemWithTitle:@"29. 弹性按钮" icon:nil objectClass:[EjectShrinkBtnsDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"30. 彩色滑块" icon:nil objectClass:[ColorSliderDemoVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"31. 圆环控制动画控制器" icon:nil objectClass:[LightControlPannelVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"32. 周选择器" icon:nil objectClass:[WeekSelectorVCDemo class]]
                        ,[KKStaticCellItem itemWithTitle:@"33. 色盘" icon:nil objectClass:[RiciColorPaletteVC class]]
                        ,[KKStaticCellItem itemWithTitle:@"34. 图片转换" icon:nil objectClass:[UIImageTransformTestVC class]]
                        ];
    
    KKStaticCellItemGroup *group = [KKStaticCellItemGroup itemGroupWithItems:items];
    self.dataArray = @[group];
}

@end
