//
//  KKSegmentControlVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKSegmentControlHeadVC.h"
#import "KKSegmentControlPageVC.h"

@class KKSegmentControlBaseLayout;
@class KKSegmentControlVC;

NS_ASSUME_NONNULL_BEGIN

@protocol KKSegmentControlVCDelegate <NSObject>
    
    /**
     数据源：返回每页控制器
     @return UIViewController 及其子类
     */
- (__kindof UIViewController *)segmentControlVC:(KKSegmentControlVC *)segmentControl viewControllerForPageAtIndex:(NSInteger)index;
    
    @end

@interface KKSegmentControlVC : UIViewController
    
    @property (nonatomic, strong) KKSegmentControlHeadVC *headVC;
    @property (nonatomic, strong) KKSegmentControlPageVC *pageVC;
    
    @property (nonatomic, assign) id<KKSegmentControlVCDelegate> delegate;
    
    /// init all items but the array of page controllers is nil
- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles
                            layout:(__kindof KKSegmentControlBaseLayout *)layout;
    
    /// designated init, init all items and page controllers once a time
- (instancetype)initWithItemTitles:(NSMutableArray<NSString *> *)itemTitles
                       controllers:(NSArray<__kindof UIViewController *> * _Nullable)controllers
                            layout:(__kindof KKSegmentControlBaseLayout *)layout;
    
    @end

NS_ASSUME_NONNULL_END
